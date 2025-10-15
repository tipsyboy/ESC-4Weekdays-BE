package com.fourweekdays.fourweekdays.inbound.model.entity;


import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.product.model.Product;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderProductItem;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class InboundProductItem extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "inbound_product_item_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inbound_id", nullable = false)
    private Inbound inbound;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_product_item_id", nullable = false)
    private PurchaseOrderProductItem purchaseOrderProductItem;

    @Column(nullable = false)
    private Integer receivedQuantity; // 입고 수량

    @Column(length = 50, nullable = true)
    private String lotNumber; // 로트번호
    private String locationCode; // 적재위치 (A-01-01) TODO: Location 엔티티 or VO 격상

    @Column
    private LocalDate expirationDate; // TODO: 이게 필요한가?

    @Column(length = 1000)
    private String description; // 비고

    // ===== 연관관계 편의 메서드 ===== //
    // ... Inbound 할당 메서드 ...

    // ===== 비즈니스 로직 ===== //
    // ... 입고 수량 검증 메서드 ...
    // ... 발주 항목 입고 수량 업데이트 메서드 ...
}
