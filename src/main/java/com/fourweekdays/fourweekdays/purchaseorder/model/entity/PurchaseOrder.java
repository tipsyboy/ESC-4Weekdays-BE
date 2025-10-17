package com.fourweekdays.fourweekdays.purchaseorder.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class PurchaseOrder extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String orderNumber; // 발주번호 (예: PO-20250415-001)

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false)
    private Vendor vendor;

    @Builder.Default
    @OneToMany(mappedBy = "purchaseOrder", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PurchaseOrderProductItem> items = new ArrayList<>();

    @Column(nullable = false)
    private LocalDateTime orderDate; // 발주일

    @Column(nullable = false)
    private LocalDateTime expectedDate; // 입고예정일

    @Enumerated(EnumType.STRING)
    private PurchaseOrderStatus status;

    @Column(nullable = false)
    private Long totalAmount; // 총 금액

    @Column(length = 1000)
    private String description; // 비고

//    @Column(length = 100)
//    private String orderedBy; // 발주 담당자

    // ===== 연관관계 편의 메서드 ===== //
    // ... 상품 추가 메서드 ...
    // ... 상품 제거 메서드 ...

    // ===== 비즈니스 로직 ===== //
    // ... 총액 계산 메서드 ...
    // ... 발주 승인 메서드 ...
    // ... 발주 확정 메서드 ...
    // ... 입고 완료 처리 메서드 ...
    // ... 발주 취소 메서드 ...
}