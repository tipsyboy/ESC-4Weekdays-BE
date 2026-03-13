package com.fourweekdays.fourweekdays.product;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import com.fourweekdays.fourweekdays.product.model.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import jakarta.persistence.EntityManager;
import org.hibernate.SessionFactory;
import org.hibernate.stat.Statistics;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@SpringBootTest(properties = "spring.jpa.properties.hibernate.default_batch_fetch_size=0") // Batch Size 0 설정
@Transactional
@ActiveProfiles("test")
public class ProductNPlusOneTest {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private EntityManager em;

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
            Vendor vendor = Vendor.builder()
                    .name("공급업체 " + i)
                    .vendorCode("VND-" + i)
                    .status(com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus.ACTIVE)
                    .build();
            vendorRepository.save(vendor);

            for (int j = 1; j <= PRODUCT_PER_VENDOR; j++) {
                Product product = Product.builder()
                        .name("상품 " + i + "-" + j)
                        .productCode("PRD-" + i + "-" + j)
                        .status(ProductStatus.ACTIVE)
                        .unitPrice(1000L * j)
                        .vendor(vendor)
                        .build();
                productRepository.save(product);
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
    @DisplayName("STEP 1: JPA N+1 문제 발생")
    void step1_n_plus_one() {
        long startTime = System.currentTimeMillis();
        List<Product> allProducts = productRepository.findAll();
        List<ProductReadDto> results = allProducts.stream()
                .map(ProductReadDto::from)
                .toList();
        long endTime = System.currentTimeMillis();
        printReport("STEP 1 JPA N+1 문제 발생", startTime, endTime);
    }

    @Test
    @DisplayName("STEP 2: Fetch Join 적용 (Batch Size 0) - XToOne 관계의 N+1문제는 Fetch Join을 통해 해결한다.")
    void step2_fetch_join_limit() {
        long startTime = System.currentTimeMillis();
        ProductSearchRequest request = new ProductSearchRequest(null, null, null, null, null, null, null, null);
        PageRequest pageable = PageRequest.of(0, 1000);
        Page<Product> products = productRepository.searchProducts(pageable, request);
        List<ProductReadDto> results = products.getContent().stream()
                .map(ProductReadDto::from)
                .toList();
        long endTime = System.currentTimeMillis();
        printReport("STEP 2 (Fetch Join Limit)", startTime, endTime);
    }

    private void printReport(String stepName, long startTime, long endTime) {
        System.out.println(" ==================================================");
        System.out.println("📊 성능 리포트 - " + stepName);
        System.out.println("--------------------------------------------------");
        System.out.println("소요 시간: " + (endTime - startTime) + "ms");
        System.out.println("실행된 쿼리 수: " + statistics.getPrepareStatementCount() + "건");
        System.out.println("==================================================");
    }
}
