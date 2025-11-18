package com.fourweekdays.fourweekdays.redis.inventory;

import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import com.fourweekdays.fourweekdays.inventory.repository.InventoryRepository;
import com.fourweekdays.fourweekdays.inventory.service.InventoryService;
import com.fourweekdays.fourweekdays.location.model.entity.Location;
import com.fourweekdays.fourweekdays.location.model.entity.LocationStatus;
import com.fourweekdays.fourweekdays.location.repository.LocationRepository;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@SpringBootTest
@ActiveProfiles("test")
class InventoryCreateOrIncreaseConcurrencyTest {

    @Autowired
    private InventoryService inventoryService;

    @Autowired
    private InventoryRepository inventoryRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private LocationRepository locationRepository;

    @Autowired
    private VendorRepository vendorRepository;

    private Long productId;
    private Long locationId;
    private final String lot = "LOT-A";

    @BeforeEach
    void setUp() {

        inventoryRepository.deleteAll();
        productRepository.deleteAll();
        locationRepository.deleteAll();
        vendorRepository.deleteAll();

        Vendor vendor = Vendor.builder()
                .vendorCode("V-TEST-001")
                .name("테스트 공급업체")
                .phoneNumber("010-1111-2222")
                .email("test@vendor.com")
                .description("테스트 벤더")
                .status(VendorStatus.ACTIVE)
                .address(null)
                .build();
        vendor = vendorRepository.save(vendor);

        Location location = Location.builder()
                .zone("Z1")
                .section("A")
                .vendorId(vendor.getId())
                .capacity(15000)
                .status(LocationStatus.AVAILABLE)
                .description("테스트 위치")
                .build();
        location = locationRepository.save(location);

        Product product = Product.builder()
                .name("테스트 상품")
                .productCode("PRD-TEST-001")
                .unit("EA")
                .unitPrice(1000L)
                .description("테스트 product")
                .status(ProductStatus.ACTIVE)
                .vendor(vendor)
                .build();
        product = productRepository.save(product);

        this.productId = product.getId();
        this.locationId = location.getId();
    }

    @Test
    void inventoryCreateOrIncreaseConcurrencyTest() throws Exception {

        int users = 100;
        int qtyPerUser = 5;

        ExecutorService executor = Executors.newFixedThreadPool(20);
        CountDownLatch latch = new CountDownLatch(users);

        int[] success = {0};
        int[] failIncrease = {0};
        int[] failLock = {0};
        int[] etcError = {0};

        long start = System.currentTimeMillis();

        for (int i = 0; i < users; i++) {
            executor.submit(() -> {
                try {
                    inventoryService.createInventoryForTest(productId, locationId, lot, qtyPerUser);
                    success[0]++;
                } catch (Exception e) {
                    String msg = e.getMessage();

                    if (msg.contains("락") || msg.contains("lock")) {
                        failLock[0]++;
                    } else if (msg.contains("재고") || msg.contains("없습니다")) {
                        failIncrease[0]++;
                    } else {
                        etcError[0]++;
                    }
                } finally {
                    latch.countDown();
                }
            });
        }

        latch.await();
        executor.shutdown();

        int finalQty = inventoryRepository.findByProductId(productId)
                .stream()
                .mapToInt(Inventory::getQuantity)
                .sum();

        long end = System.currentTimeMillis();
        long duration = end - start;

        double successRate = (success[0] * 100.0) / users;
        double failIncreaseRate = (failIncrease[0] * 100.0) / users;
        double failLockRate = (failLock[0] * 100.0) / users;
        double etcErrorRate = (etcError[0] * 100.0) / users;

        double qps = users / (duration / 1000.0);

        // ================= 출력 ===================
        System.out.println("==============================================================");
        System.out.printf("🌐 총 요청한 사용자 수   : %d\n", users);
        System.out.printf("📦 초기 재고             : %d\n", 0);
        System.out.printf("📥 받은 재고             : %d\n", finalQty);
        System.out.printf("📤 발급된 사용자 수       : %d\n\n", success[0]);

        System.out.printf("🟢 정상 증가 성공        : %d (%.2f%%)\n", success[0], successRate);
        System.out.printf("🔴 증가 요청 실패        : %d (%.2f%%)\n", failIncrease[0], failIncreaseRate);
        System.out.printf("🔒 락 요청 실패          : %d (%.2f%%)\n", failLock[0], failLockRate);
        System.out.printf("⚠️ 기타 오류            : %d (%.2f%%)\n\n", etcError[0], etcErrorRate);

        System.out.printf("📊 총 요청 수            : %d\n", users);
        System.out.printf("⏱  총 소요 시간         : %d ms (%.2f sec)\n", duration, duration / 1000.0);
        System.out.printf("🚀 평균 처리 속도(QPS)    : %.2f req/sec\n", qps);
        System.out.println("==============================================================\n");
    }
}
