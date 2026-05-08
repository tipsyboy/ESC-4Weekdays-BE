package com.fourweekdays.fourweekdays.inbound;

import com.fourweekdays.fourweekdays.inbound.dto.InboundReadDto;
import com.fourweekdays.fourweekdays.inbound.domain.Inbound;
import com.fourweekdays.fourweekdays.inbound.domain.InboundProduct;
import com.fourweekdays.fourweekdays.inbound.domain.InboundStatus;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.member.model.entity.AuthStatus;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.model.entity.MemberRole;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderProduct;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jakarta.persistence.EntityManager;
import org.hibernate.SessionFactory;
import org.hibernate.stat.Statistics;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import static com.fourweekdays.fourweekdays.inbound.domain.QInbound.inbound;
import static com.fourweekdays.fourweekdays.inbound.domain.QInboundProduct.inboundProduct;
import static com.fourweekdays.fourweekdays.member.model.entity.QMember.member;
import static com.fourweekdays.fourweekdays.product.model.entity.QProduct.product;
import static com.fourweekdays.fourweekdays.purchaseorder.domain.QPurchaseOrder.purchaseOrder;
import static com.fourweekdays.fourweekdays.purchaseorder.domain.QPurchaseOrderProduct.purchaseOrderProduct;
import static com.fourweekdays.fourweekdays.vendor.model.entity.QVendor.vendor;

@SpringBootTest(properties = "spring.jpa.properties.hibernate.default_batch_fetch_size=0")
@Transactional
@ActiveProfiles("test")
class InboundNPlusOneTest {

    private static final int INBOUND_COUNT = 80;
    private static final int PRODUCTS_PER_INBOUND = 5;
    private static final int PAGE_SIZE = 30;

    @Autowired
    private InboundRepository inboundRepository;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private PurchaseOrderRepository purchaseOrderRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private JPAQueryFactory queryFactory;

    private Statistics statistics;

    @BeforeEach
    void setUp() {
        SessionFactory sessionFactory = em.getEntityManagerFactory().unwrap(SessionFactory.class);
        statistics = sessionFactory.getStatistics();
        statistics.clear();
        statistics.setStatisticsEnabled(true);

        Member manager = memberRepository.save(Member.builder()
                .email("inbound-manager@test.com")
                .password("password")
                .name("입고 담당자")
                .phoneNumber("01012345678")
                .joinAt(LocalDateTime.now())
                .role(MemberRole.MANAGER)
                .status(AuthStatus.ACTIVE)
                .build());

        Vendor sharedVendor = vendorRepository.save(Vendor.builder()
                .name("입고 테스트 공급업체")
                .vendorCode("VND-INBOUND-1")
                .status(VendorStatus.ACTIVE)
                .build());

        for (int i = 1; i <= INBOUND_COUNT; i++) {
            PurchaseOrder po = PurchaseOrder.builder()
                    .orderCode("PO-" + i)
                    .vendor(sharedVendor)
                    .manager(manager)
                    .status(PurchaseOrderStatus.REQUESTED)
                    .description("입고 테스트용 발주")
                    .orderDate(LocalDateTime.now().minusDays(1))
                    .expectedDate(LocalDateTime.now().plusDays(1))
                    .build();

            for (int j = 1; j <= PRODUCTS_PER_INBOUND; j++) {
                Product productEntity = productRepository.save(Product.builder()
                        .name("입고 상품 " + i + "-" + j)
                        .productCode("PRD-IN-" + i + "-" + j)
                        .status(ProductStatus.ACTIVE)
                        .unit("EA")
                        .unitPrice(1000L + j)
                        .vendor(sharedVendor)
                        .build());

                po.addItem(PurchaseOrderProduct.builder()
                        .product(productEntity)
                        .orderedQuantity(10 + j)
                        .description("발주 상품")
                        .build());
            }

            purchaseOrderRepository.save(po);

            Inbound inboundEntity = Inbound.builder()
                    .inboundCode("IB-" + i)
                    .status(InboundStatus.SCHEDULED)
                    .manager(manager)
                    .purchaseOrder(po)
                    .scheduledDate(LocalDateTime.now().plusDays(2))
                    .description("입고 테스트 데이터")
                    .build();

            for (PurchaseOrderProduct poProduct : po.getProducts()) {
                InboundProduct.builder()
                        .inbound(inboundEntity)
                        .product(poProduct.getProduct())
                        .purchaseOrderProduct(poProduct)
                        .receivedQuantity(poProduct.getOrderedQuantity())
                        .lotNumber("LOT-" + i + "-" + poProduct.getId())
                        .description("입고 품목")
                        .build();
            }

            inboundRepository.save(inboundEntity);
        }

        em.flush();
        em.clear();
        statistics.clear();
    }

    @AfterEach
    void tearDown() {
        statistics.setStatisticsEnabled(false);
    }

    @Test
    @DisplayName("STEP 1: Inbound N+1 문제 - 컬렉션 및 하위 연관 지연 로딩 폭발")
    void step1_n_plus_one() {
        long startTime = System.currentTimeMillis();

        List<Long> inboundIds = fetchPagedInboundIds();
        statistics.clear();

        List<Inbound> selectedInbounds = queryFactory
                .selectFrom(inbound)
                .where(inbound.id.in(inboundIds))
                .orderBy(inbound.id.desc())
                .fetch();

        List<InboundReadDto> results = selectedInbounds.stream()
                .map(InboundReadDto::from)
                .toList();

        long endTime = System.currentTimeMillis();

        printBasicReport(
                "STEP 1 (Inbound JPA N+1)",
                startTime,
                endTime,
                PAGE_SIZE,
                results.size()
        );
    }

    @Test
    @DisplayName("STEP 2: Collection Fetch Join 적용 (Batch Size 0) - XToMany N+1")
    void step2_collection_fetch_join() {
        long startTime = System.currentTimeMillis();

        List<Long> inboundIds = fetchPagedInboundIds();
        long simulatedPagedRootCount = simulateJoinedRowPagingUniqueRootCount();
        statistics.clear();

        List<Inbound> selectedInbounds = queryFactory
                .selectDistinct(inbound)
                .from(inbound)
                .leftJoin(inbound.manager, member).fetchJoin()
                .leftJoin(inbound.purchaseOrder, purchaseOrder).fetchJoin()
                .leftJoin(purchaseOrder.vendor, vendor).fetchJoin()
                .leftJoin(inbound.products, inboundProduct).fetchJoin()
                .leftJoin(inboundProduct.product, product).fetchJoin()
                .leftJoin(inboundProduct.purchaseOrderProduct, purchaseOrderProduct).fetchJoin()
                .where(inbound.id.in(inboundIds))
                .orderBy(inbound.id.desc())
                .fetch();

        List<InboundReadDto> results = selectedInbounds.stream()
                .map(InboundReadDto::from)
                .toList();

        long endTime = System.currentTimeMillis();

        printFetchJoinReport(
                "STEP 2 (Collection Fetch Join)",
                startTime,
                endTime,
                PAGE_SIZE,
                results.size(),
                countJoinedRowsForIds(inboundIds),
                simulatedPagedRootCount
        );
    }

    private List<Long> fetchPagedInboundIds() {
        return queryFactory
                .select(inbound.id)
                .from(inbound)
                .orderBy(inbound.id.desc())
                .limit(PAGE_SIZE)
                .fetch();
    }

    private long countJoinedRowsForIds(List<Long> inboundIds) {
        Long joinedRowCount = queryFactory
                .select(inboundProduct.count())
                .from(inbound)
                .leftJoin(inbound.products, inboundProduct)
                .where(inbound.id.in(inboundIds))
                .fetchOne();
        return joinedRowCount != null ? joinedRowCount : 0L;
    }

    private long simulateJoinedRowPagingUniqueRootCount() {
        return queryFactory
                .select(inbound.id)
                .from(inbound)
                .leftJoin(inbound.products, inboundProduct)
                .orderBy(inbound.id.desc(), inboundProduct.id.asc())
                .limit(PAGE_SIZE)
                .fetch()
                .stream()
                .distinct()
                .count();
    }

    private void printBasicReport(String stepName, long startTime, long endTime, int requestedRootCount, int actualRootCount) {
        System.out.println("==================================================");
        System.out.println("📊 성능 리포트 - " + stepName);
        System.out.println("--------------------------------------------------");
        System.out.println("요청 루트 엔티티 수: " + requestedRootCount + "건");
        System.out.println("실제 루트 엔티티 수: " + actualRootCount + "건");
        System.out.println("전략: 지연 로딩 그대로 조회");
        System.out.println("의미: 컬렉션과 하위 연관에서 순수 N+1 재현");
        System.out.println("소요 시간: " + (endTime - startTime) + "ms");
        System.out.println("실행된 쿼리 수: " + statistics.getPrepareStatementCount() + "건");
        System.out.println("==================================================");
    }

    private void printFetchJoinReport(String stepName, long startTime, long endTime, int requestedRootCount,
                                      int actualRootCount, long joinedRowCount, long simulatedPagedRootCount) {
        double duplicateFactor = actualRootCount == 0 ? 0.0 : (double) joinedRowCount / actualRootCount;

        System.out.println("==================================================");
        System.out.println("📊 성능 리포트 - " + stepName);
        System.out.println("--------------------------------------------------");
        System.out.println("요청 루트 엔티티 수: " + requestedRootCount + "건");
        System.out.println("실제 루트 엔티티 수: " + actualRootCount + "건");
        System.out.println("전략: XToMany collection fetch join");
        System.out.println("기대 효과: 쿼리 수 감소");
        System.out.println("조인 결과 row 수: " + joinedRowCount + "건");
        System.out.println("row 중복 배수: " + String.format("%.2f", duplicateFactor) + "배");
        System.out.println("trade-off: row 중복으로 메모리 부담 및 직접 페이징 왜곡 가능");
        System.out.println("조인 row 기준 직접 페이징 시 예상 루트 수: " + simulatedPagedRootCount + "건");
        System.out.println("소요 시간: " + (endTime - startTime) + "ms");
        System.out.println("실행된 쿼리 수: " + statistics.getPrepareStatementCount() + "건");
        System.out.println("==================================================");
    }
}
