package com.fourweekdays.fourweekdays.redis.outbound;

import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import com.fourweekdays.fourweekdays.inventory.repository.InventoryRepository;
import com.fourweekdays.fourweekdays.location.model.entity.Location;
import com.fourweekdays.fourweekdays.location.model.entity.LocationStatus;
import com.fourweekdays.fourweekdays.location.repository.LocationRepository;
import com.fourweekdays.fourweekdays.member.model.entity.AuthStatus;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.model.entity.MemberRole;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.order.model.entity.Order;
import com.fourweekdays.fourweekdays.order.model.entity.OrderProductItem;
import com.fourweekdays.fourweekdays.order.model.entity.OrderStatus;
import com.fourweekdays.fourweekdays.order.repository.OrderProductItemRepository;
import com.fourweekdays.fourweekdays.order.repository.OrderRepository;
import com.fourweekdays.fourweekdays.outbound.model.entity.Outbound;
import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundProductItem;
import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundStatus;
import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundType;
import com.fourweekdays.fourweekdays.outbound.repository.OutboundInventoryHistoryRepository;
import com.fourweekdays.fourweekdays.outbound.repository.OutboundProductItemRepository;
import com.fourweekdays.fourweekdays.outbound.repository.OutboundRepository;
import com.fourweekdays.fourweekdays.outbound.service.OutboundService;
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

import java.time.LocalDateTime;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@SpringBootTest
@ActiveProfiles("test")
class OutboundApproveConcurrencyTest {

    @Autowired private OutboundService outboundService;

    @Autowired private InventoryRepository inventoryRepository;
    @Autowired private OutboundInventoryHistoryRepository outboundInventoryHistoryRepository;
    @Autowired private OutboundProductItemRepository outboundProductItemRepository;
    @Autowired private OutboundRepository outboundRepository;

    @Autowired private OrderRepository orderRepository;
    @Autowired private OrderProductItemRepository orderProductItemRepository;

    @Autowired private ProductRepository productRepository;
    @Autowired private VendorRepository vendorRepository;
    @Autowired private LocationRepository locationRepository;

    @Autowired private MemberRepository memberRepository;

    private Long outboundId;

    @BeforeEach
    void setUp() {

        outboundInventoryHistoryRepository.deleteAll();
        outboundProductItemRepository.deleteAll();
        outboundRepository.deleteAll();
        orderProductItemRepository.deleteAll();
        orderRepository.deleteAll();
        inventoryRepository.deleteAll();
        locationRepository.deleteAll();
        productRepository.deleteAll();
        vendorRepository.deleteAll();
        memberRepository.deleteAll();

        // 관리자 생성
        Member manager = Member.builder()
                .name("관리자")
                .email("admin@test.com")
                .password("pw")
                .role(MemberRole.ADMIN)
                .status(AuthStatus.ACTIVE)
                .build();
        manager = memberRepository.save(manager);

        // 벤더 생성
        Vendor vendor = Vendor.builder()
                .vendorCode("V-TEST-001")
                .name("테스트 벤더")
                .phoneNumber("010-1111-2222")
                .email("vendor@test.com")
                .status(VendorStatus.ACTIVE)
                .build();
        vendor = vendorRepository.save(vendor);

        // 로케이션 생성
        Location location = Location.builder()
                .zone("Z1")
                .section("A")
                .vendorId(vendor.getId())
                .capacity(1000)
                .status(LocationStatus.AVAILABLE)
                .description("테스트 위치")
                .build();
        location = locationRepository.save(location);

        // 상품 생성
        Product product = Product.builder()
                .productCode("P-TEST-001")
                .name("테스트상품")
                .unit("EA")
                .unitPrice(1000L)
                .status(ProductStatus.ACTIVE)
                .vendor(vendor)
                .build();
        product = productRepository.save(product);

        // 재고 생성
        Inventory inventory = Inventory.builder()
                .product(product)
                .location(location)
                .quantity(50)
                .lotNumber("LOT-001")
                .build();
        inventory = inventoryRepository.save(inventory);

        // 주문 생성
        Order order = Order.builder()
                .orderCode("O-TEST-001")
                .status(OrderStatus.APPROVED)
                .orderDate(LocalDateTime.now())
                .dueDate(LocalDateTime.now())
                .build();
        order = orderRepository.save(order);

        // 주문 상품 생성
        OrderProductItem opItem = OrderProductItem.builder()
                .order(order)
                .product(product)
                .orderedQuantity(20)
                .description("테스트 상품")
                .build();
        opItem = orderProductItemRepository.save(opItem);

        // 출고 생성
        Outbound outbound = Outbound.builder()
                .outboundCode("OB-TEST-001")
                .status(OutboundStatus.REQUESTED)
                .outboundType(OutboundType.SALE)
                .order(order)
                .outboundManager(manager)
                .scheduledDate(LocalDateTime.now())
                .description("출고 테스트")
                .build();
        outbound = outboundRepository.save(outbound);

        // 출고 상품 생성
        OutboundProductItem outboundItem = OutboundProductItem.builder()
                .outbound(outbound)
                .product(product)
                .orderProductItem(opItem)
                .orderedQuantity(20)
                .description("출고상품")
                .build();
        outboundProductItemRepository.save(outboundItem);

        this.outboundId = outbound.getId();
    }

    @Test
    void outboundApproveConcurrencyTest() throws Exception {

        int users = 200;

        ExecutorService executor = Executors.newFixedThreadPool(users);
        CountDownLatch latch = new CountDownLatch(users);

        long start = System.currentTimeMillis();

        int[] success = {0};
        int[] lockingErrors = {0};

        for (int i = 0; i < users; i++) {
            executor.submit(() -> {
                try {
                    outboundService.approveOutbound(outboundId);
                    success[0]++;
                } catch (Exception e) {
                    lockingErrors[0]++;
                } finally {
                    latch.countDown();
                }
            });
        }

        latch.await();
        long end = System.currentTimeMillis();

        int finalStock = inventoryRepository.findAll().stream()
                .mapToInt(i -> i.getQuantity())
                .sum();

        System.out.println("\n\n================= 🚚 출고 승인 동시성 테스트 =================");
        System.out.println("시도한 승인 요청 수      : " + users);
        System.out.println("승인 성공 횟수           : " + success[0]);
        System.out.println("락 충돌 예외             : " + lockingErrors[0]);
        System.out.println("최종 재고 수량           : " + finalStock);
        System.out.println("총 소요 시간(ms)         : " + (end - start));
        System.out.println("단일 승인 여부           : " + (success[0] == 1));
        System.out.println("===============================================================\n\n");
    }
}
