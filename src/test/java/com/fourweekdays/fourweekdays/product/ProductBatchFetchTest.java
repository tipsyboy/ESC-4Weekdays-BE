package com.fourweekdays.fourweekdays.product;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import com.fourweekdays.fourweekdays.product.model.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
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

import java.util.List;

import static com.fourweekdays.fourweekdays.product.model.entity.QProduct.product;
import static com.fourweekdays.fourweekdays.vendor.model.entity.QVendor.vendor;

@SpringBootTest(properties = "spring.jpa.properties.hibernate.default_batch_fetch_size=100")
@Transactional
@ActiveProfiles("test")
public class ProductBatchFetchTest {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private EntityManager em;

    @Autowired
    private JPAQueryFactory queryFactory;

    private Statistics statistics;

    private static final int VENDOR_COUNT = 300;
    private static final int PRODUCT_PER_VENDOR = 5;

    @BeforeEach
    void setUp() {
        SessionFactory sessionFactory = em.getEntityManagerFactory().unwrap(SessionFactory.class);
        statistics = sessionFactory.getStatistics();
        statistics.clear();
        statistics.setStatisticsEnabled(true);

        for (int i = 1; i <= VENDOR_COUNT; i++) {
            Vendor vendorEntity = Vendor.builder()
                    .name("공급업체 " + i)
                    .vendorCode("VND-" + i)
                    .status(com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus.ACTIVE)
                    .build();
            vendorRepository.save(vendorEntity);

            for (int j = 1; j <= PRODUCT_PER_VENDOR; j++) {
                Product productEntity = Product.builder()
                        .name("상품 " + i + "-" + j)
                        .productCode("PRD-" + i + "-" + j)
                        .status(ProductStatus.ACTIVE)
                        .unitPrice(1000L * j)
                        .vendor(vendorEntity)
                        .build();
                productRepository.save(productEntity);
            }
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
    @DisplayName("STEP 3: Batch Fetch Size(100) Only 적용 - XToOne N+1 완화")
    void test_step3_batch_fetch_size() {
        long startTime = System.currentTimeMillis();

        List<Product> allProducts = productRepository.findAll();
        List<ProductReadDto> results = allProducts.stream()
                .map(ProductReadDto::from)
                .toList();

        long endTime = System.currentTimeMillis();
        printReport("STEP 3 (Batch Fetch Size(100) Only 적용)", startTime, endTime);
    }

    @Test
    @DisplayName("STEP 4: Fetch Join + Batch Fetch Size(100) 적용 - 혼합")
    void test_step4_fetch_join_with_batch_fetch_size() {
        long startTime = System.currentTimeMillis();

        ProductSearchRequest request = new ProductSearchRequest(null, null, null, null, null, null, null, null);
        var pageable = org.springframework.data.domain.PageRequest.of(0, 1000);
        
        var products = productRepository.searchProducts(pageable, request);
        
        List<ProductReadDto> results = products.getContent().stream()
                .map(ProductReadDto::from)
                .toList();

        long endTime = System.currentTimeMillis();
        printReport("STEP 4 (Fetch Join + Batch Fetch Size(100) 적용)", startTime, endTime);
    }

    @Test
    @DisplayName("STEP 5: DTO Projection")
    void test_step5_dto_projection() {
        long startTime = System.currentTimeMillis();

        // DTO Projection의 묘미: 필요한 데이터만 조인해서 한 번에 뽑아옴
        List<ProductOptimizedDto> results = queryFactory
                .select(Projections.constructor(ProductOptimizedDto.class,
                        product.id,
                        product.productCode,
                        product.name,
                        vendor.name,
                        product.unitPrice,
                        product.status,
                        vendor.productList.size(), // 핵심: 컬렉션의 size()도 한 번에 조인 쿼리로 포함됨
                        product.createdAt
                ))
                .from(product)
                .leftJoin(product.vendor, vendor)
                .offset(0)
                .limit(1000)
                .orderBy(product.id.desc())
                .fetch();

        long endTime = System.currentTimeMillis();
        printReport("STEP 5 (DTO Projection)", startTime, endTime);
    }

    private void printReport(String stepName, long startTime, long endTime) {
        System.out.println("\n==================================================");
        System.out.println("📊 성능 리포트 - " + stepName);
        System.out.println("--------------------------------------------------");
        System.out.println("소요 시간: " + (endTime - startTime) + "ms");
        System.out.println("실행된 쿼리 수: " + statistics.getPrepareStatementCount() + "건");
        System.out.println("==================================================\n");
    }
}
