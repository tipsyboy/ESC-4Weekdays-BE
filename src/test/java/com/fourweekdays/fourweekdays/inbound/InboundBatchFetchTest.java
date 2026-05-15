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
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderItem;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import com.querydsl.core.types.Projections;
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
import static com.fourweekdays.fourweekdays.vendor.model.entity.QVendor.vendor;

@SpringBootTest(properties = "spring.jpa.properties.hibernate.default_batch_fetch_size=100")
@Transactional
@ActiveProfiles("test")
class InboundBatchFetchTest {

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
                .email("inbound-batch@test.com")
                .password("password")
                .name("입고 배치 담당자")
                .phoneNumber("01087654321")
                .joinAt(LocalDateTime.now())
                .role(MemberRole.MANAGER)
                .status(AuthStatus.ACTIVE)
                .build());

        Vendor sharedVendor = vendorRepository.save(Vendor.builder()
                .name("입고 배치 공급업체")
                .vendorCode("VND-INBOUND-BATCH-1")
                .status(VendorStatus.ACTIVE)
                .build());

        for (int i = 1; i <= INBOUND_COUNT; i++) {
            PurchaseOrder po = PurchaseOrder.builder()
                    .orderCode("PO-BATCH-" + i)
                    .vendor(sharedVendor)
                    .manager(manager)
                    .status(PurchaseOrderStatus.REQUESTED)
                    .description("배치 테스트 발주")
                    .orderDate(LocalDateTime.now().minusDays(1))
                    .expectedDate(LocalDateTime.now().plusDays(1))
                    .build();

            for (int j = 1; j <= PRODUCTS_PER_INBOUND; j++) {
                Product productEntity = productRepository.save(Product.builder()
                        .name("배치 입고 상품 " + i + "-" + j)
                        .productCode("PRD-IN-BATCH-" + i + "-" + j)
                        .status(ProductStatus.ACTIVE)
                        .unit("EA")
                        .unitPrice(2000L + j)
                        .vendor(sharedVendor)
                        .build());

                po.addItem(PurchaseOrderItem.builder()
                        .product(productEntity)
                        .orderedQuantity(20 + j)
                        .description("배치 발주 상품")
                        .build());
            }

            purchaseOrderRepository.save(po);

            Inbound inboundEntity = Inbound.builder()
                    .inboundCode("IB-BATCH-" + i)
                    .status(InboundStatus.SCHEDULED)
                    .manager(manager)
                    .purchaseOrder(po)
                    .scheduledDate(LocalDateTime.now().plusDays(2))
                    .description("배치 입고 테스트 데이터")
                    .build();

            for (PurchaseOrderItem poProduct : po.getItems()) {
                InboundProduct.builder()
                        .inbound(inboundEntity)
                        .product(poProduct.getProduct())
                        .purchaseOrderItem(poProduct)
                        .receivedQuantity(poProduct.getOrderedQuantity())
                        .lotNumber("BATCH-LOT-" + i + "-" + poProduct.getId())
                        .description("배치 입고 품목")
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
    @DisplayName("STEP 3: Batch Fetch Size Only 적용 (100) - ToMany N+1 완화")
    void step3_batch_fetch_size_only() {
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
                "STEP 3 (Batch Fetch Size Only)",
                startTime,
                endTime,
                PAGE_SIZE,
                results.size()
        );
    }

    @Test
    @DisplayName("STEP 4: XToOne Fetch Join + Batch Fetch Size")
    void step4_fetch_join_with_batch_fetch_size() {
        long startTime = System.currentTimeMillis();

        List<Long> inboundIds = fetchPagedInboundIds();
        statistics.clear();

        List<Inbound> selectedInbounds = queryFactory
                .selectFrom(inbound)
                .leftJoin(inbound.manager, member).fetchJoin()
                .leftJoin(inbound.purchaseOrder, purchaseOrder).fetchJoin()
                .leftJoin(purchaseOrder.vendor, vendor).fetchJoin()
                .where(inbound.id.in(inboundIds))
                .orderBy(inbound.id.desc())
                .fetch();

        List<InboundReadDto> results = selectedInbounds.stream()
                .map(InboundReadDto::from)
                .toList();

        long endTime = System.currentTimeMillis();

        printMixedStrategyReport(
                "STEP 4 (XToOne Fetch Join + Batch Fetch Size)",
                startTime,
                endTime,
                PAGE_SIZE,
                results.size()
        );
    }

    @Test
    @DisplayName("STEP 5: DTO Projection - 평탄 조회 후 응답 구성")
    void step5_dto_projection() {
        long startTime = System.currentTimeMillis();

        List<Long> inboundIds = fetchPagedInboundIds();
        statistics.clear();

        List<InboundOptimizedDto> results = queryFactory
                .select(Projections.constructor(InboundOptimizedDto.class,
                        inbound.id,
                        inbound.inboundCode,
                        member.name,
                        vendor.name,
                        purchaseOrder.orderCode,
                        product.productCode,
                        product.name,
                        inboundProduct.receivedQuantity,
                        inbound.createdAt
                ))
                .from(inbound)
                .join(inbound.manager, member)
                .join(inbound.purchaseOrder, purchaseOrder)
                .join(purchaseOrder.vendor, vendor)
                .join(inbound.products, inboundProduct)
                .join(inboundProduct.product, product)
                .where(inbound.id.in(inboundIds))
                .orderBy(inbound.id.desc(), inboundProduct.id.asc())
                .fetch();

        long endTime = System.currentTimeMillis();

        long rootCount = results.stream()
                .map(InboundOptimizedDto::getInboundId)
                .distinct()
                .count();

        printProjectionReport(
                "STEP 5 (DTO Projection)",
                startTime,
                endTime,
                PAGE_SIZE,
                (int) rootCount,
                results.size()
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

    private void printBasicReport(String stepName, long startTime, long endTime, int requestedRootCount, int actualRootCount) {
        System.out.println("==================================================");
        System.out.println("📊 성능 리포트 - " + stepName);
        System.out.println("--------------------------------------------------");
        System.out.println("요청 루트 엔티티 수: " + requestedRootCount + "건");
        System.out.println("실제 루트 엔티티 수: " + actualRootCount + "건");
        System.out.println("전략: XToMany batch fetch size only");
        System.out.println("기대 효과: row 뻥튀기 없이 N+1 완화");
        System.out.println("trade-off: fetch join보다 쿼리 수는 더 나올 수 있음");
        System.out.println("소요 시간: " + (endTime - startTime) + "ms");
        System.out.println("실행된 쿼리 수: " + statistics.getPrepareStatementCount() + "건");
        System.out.println("==================================================");
    }

    private void printMixedStrategyReport(String stepName, long startTime, long endTime, int requestedRootCount, int actualRootCount) {
        System.out.println("==================================================");
        System.out.println("📊 성능 리포트 - " + stepName);
        System.out.println("--------------------------------------------------");
        System.out.println("요청 루트 엔티티 수: " + requestedRootCount + "건");
        System.out.println("실제 루트 엔티티 수: " + actualRootCount + "건");
        System.out.println("전략: XToOne fetch join + XToMany batch fetch");
        System.out.println("기대 효과: ToOne 쿼리는 줄이고, ToMany row 뻥튀기는 피하는 절충안");
        System.out.println("포인트: fetch join의 장점과 batch fetch의 안정성을 함께 사용");
        System.out.println("소요 시간: " + (endTime - startTime) + "ms");
        System.out.println("실행된 쿼리 수: " + statistics.getPrepareStatementCount() + "건");
        System.out.println("==================================================");
    }

    private void printProjectionReport(String stepName, long startTime, long endTime, int requestedRootCount, int actualRootCount,
                                       long projectionRowCount) {
        double flatRowsPerRoot = actualRootCount == 0 ? 0.0 : (double) projectionRowCount / actualRootCount;

        System.out.println("==================================================");
        System.out.println("📊 성능 리포트 - " + stepName);
        System.out.println("--------------------------------------------------");
        System.out.println("요청 루트 엔티티 수: " + requestedRootCount + "건");
        System.out.println("실제 루트 엔티티 수: " + actualRootCount + "건");
        System.out.println("Projection row 수: " + projectionRowCount + "건");
        System.out.println("루트당 평탄 row 수: " + String.format("%.2f", flatRowsPerRoot) + "배");
        System.out.println("소요 시간: " + (endTime - startTime) + "ms");
        System.out.println("실행된 쿼리 수: " + statistics.getPrepareStatementCount() + "건");
        System.out.println("==================================================");
    }
}
