package com.fourweekdays.fourweekdays.purchaseorder.domain;

import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.product.domain.Product;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class PurchaseOrderItem extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_id", nullable = false)
    private PurchaseOrder purchaseOrder;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(nullable = false)
    private Integer orderedQuantity; // 발주 수량

    private Long orderUnitPrice;

    @Column(length = 500)
    private String description; // 비고

    @Builder
    public PurchaseOrderItem(Product product, Integer orderedQuantity, Long orderUnitPrice, String description) {
        this.product = product;
        this.orderedQuantity = orderedQuantity;
        this.orderUnitPrice = orderUnitPrice;
        this.description = description;
    }

    // ===== 연관관계 편의 메서드 ===== //
    public void mappingPurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
        purchaseOrder.getItems().add(this);
    }

    // ===== 비즈니스 로직 ===== //
    public Long calculateAmount() {
        return getOrderUnitPrice() * orderedQuantity;
    }

    public Integer getOrderQuantity() {
        return orderedQuantity;
    }

    public Long getOrderUnitPrice() {
        return orderUnitPrice != null ? orderUnitPrice : product.getUnitPrice();
    }

    // ... 입고 진행률 조회 메서드 (Inbound에서 집계) ...
}
