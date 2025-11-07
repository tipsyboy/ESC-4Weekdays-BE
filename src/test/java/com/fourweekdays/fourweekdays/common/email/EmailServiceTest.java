package com.fourweekdays.fourweekdays.common.email;

import com.fourweekdays.fourweekdays.common.vo.Address;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderProduct;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.purchaseorder.service.PurchaseOrderService;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import jakarta.mail.MessagingException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Transactional
@SpringBootTest
@TestPropertySource(locations = "classpath:.env")
class EmailServiceTest {

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private PurchaseOrderRepository purchaseOrderRepository;

    @Autowired
    private PurchaseOrderService purchaseOrderService;

    @Test
    void approveOrder_ShouldSendEmailToVendor() throws MessagingException {
        // --- 1️⃣ Vendor 생성 ---
        Address address = Address.builder()
                .zipcode("06023")
                .street("서울특별시 강남구 화장품로 123")
                .detail("뷰티타워 5층")
                .city("서울")
                .country("KR")
                .build();

        Vendor vendor = Vendor.builder()
                .name("뷰티랩코리아")
                .vendorCode("V-01201-0123")
                .email("tipsyboy2025@gmail.com")
                .status(VendorStatus.ACTIVE)
                .address(address)
                .build();
        vendorRepository.save(vendor);

        // --- 2️⃣ Product (상품 마스터) 생성 ---
        Product cleanser = Product.builder()
                .productCode("C-001")
                .name("퓨어 클렌징폼 150ml")
                .unitPrice(12000L)
                .build();

        Product toner = Product.builder()
                .productCode("C-002")
                .name("모이스처 밸런싱 토너 200ml")
                .unitPrice(18000L)
                .build();

        Product cream = Product.builder()
                .productCode("C-003")
                .name("하이드라 수분 크림 50ml")
                .unitPrice(25000L)
                .build();

        productRepository.saveAll(List.of(cleanser, toner, cream));

        // --- 3️⃣ PurchaseOrderProduct (발주 품목) 생성 ---
        List<PurchaseOrderProduct> orderProducts = List.of(
                PurchaseOrderProduct.builder()
                        .product(cleanser)
                        .orderedQuantity(30)
                        .description("기초 세안 라인")
                        .build(),
                PurchaseOrderProduct.builder()
                        .product(toner)
                        .orderedQuantity(25)
                        .description("보습 라인 구성")
                        .build(),
                PurchaseOrderProduct.builder()
                        .product(cream)
                        .orderedQuantity(20)
                        .description("베스트셀러 크림")
                        .build()
        );

        // --- 4️⃣ 총 금액 계산 ---
        Long totalAmount = orderProducts.stream()
                .mapToLong(PurchaseOrderProduct::calculateAmount)
                .sum();

        // --- 5️⃣ PurchaseOrder 생성 (품목 포함) ---
        PurchaseOrder order = PurchaseOrder.builder()
                .orderCode("PO-COS-002")
                .vendor(vendor)
                .status(PurchaseOrderStatus.REQUESTED)
                .orderDate(LocalDateTime.now())
                .totalAmount(totalAmount)
                .build();

        // 양방향 연관관계 설정
        orderProducts.forEach(op -> op.mappingPurchaseOrder(order));

        purchaseOrderRepository.save(order);

        // --- 6️⃣ 승인 트리거 → 메일 발송 ---
        purchaseOrderService.approve(order.getId());
    }
}
