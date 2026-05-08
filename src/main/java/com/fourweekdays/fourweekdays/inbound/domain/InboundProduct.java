package com.fourweekdays.fourweekdays.inbound.domain;


import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.location.model.entity.Location;
import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderProduct;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class InboundProduct extends BaseEntity {

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
    @JoinColumn(name = "purchase_order_product_item_id")
    private PurchaseOrderProduct purchaseOrderProduct;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "location_id")
    private Location location;

    private Integer expectedQuantity;

    @Column(nullable = false)
    private Integer receivedQuantity; // 입고 수량

    @Column(nullable = false)
    private Integer defectQuantity = 0;

    @Column(length = 50, nullable = true)
    private String lotNumber; // 로트번호
    private String locationCode; // 적재위치 (A-01-01) TODO: Location 엔티티 or VO 격상

//    @Column
//    private LocalDate expirationDate; // TODO: 이게 필요한가?

    @Column(length = 1000)
    private String description; // 비고

    @Column(length = 1000)
    private String memo;

    @Builder
    public InboundProduct(Inbound inbound, Product product,
                          PurchaseOrderProduct purchaseOrderProduct,
                          Location location,
                          Integer expectedQuantity,
                          Integer receivedQuantity,
                          Integer defectQuantity,
                          String lotNumber,
                          String locationCode,
                          String description,
                          String memo) {
        if (inbound != null) {
            assignInbound(inbound);
        }
        this.product = product;
        this.purchaseOrderProduct = purchaseOrderProduct;
        this.location = location;
        this.expectedQuantity = expectedQuantity;
        this.receivedQuantity = receivedQuantity != null ? receivedQuantity : 0;
        this.defectQuantity = defectQuantity != null ? defectQuantity : 0;
        this.lotNumber = lotNumber;
        this.locationCode = locationCode;
        this.description = description;
        this.memo = memo;
    }

    // ===== 연관관계 편의 메서드 ===== //
    public void assignInbound(Inbound inbound) {
        if (this.inbound == inbound) {
            return;
        }
        this.inbound = inbound;
        if (!inbound.getProducts().contains(this)) {
            inbound.getProducts().add(this);
        }
    }

    // ===== 비즈니스 로직 ===== //
    // ... 입고 수량 검증 메서드 ...
    public void updateInspectionResult(int receivedQuantity) {
        this.receivedQuantity = receivedQuantity;
    }

    public Integer getExpectedQuantity() {
        if (expectedQuantity != null) {
            return expectedQuantity;
        }
        return purchaseOrderProduct != null ? purchaseOrderProduct.getOrderedQuantity() : receivedQuantity;
    }

    public String getMemo() {
        return memo != null ? memo : description;
    }

    public void updateReceipt(Location location, Integer receivedQuantity, Integer defectQuantity, String memo) {
        this.location = location;
        this.locationCode = location != null ? location.getLocationCode() : null;
        this.receivedQuantity = receivedQuantity != null ? receivedQuantity : 0;
        this.defectQuantity = defectQuantity != null ? defectQuantity : 0;
        this.memo = memo;
    }
}
