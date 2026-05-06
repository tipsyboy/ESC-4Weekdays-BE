package com.fourweekdays.fourweekdays.product.domain;

import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Product extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String productCode;

    @Column(nullable = false, length = 200)
    private String name;

    @Column(nullable = false, length = 100)
    private String category;

    @Column(nullable = false)
    private Long unitPrice;

    @Column(nullable = false)
    private Integer boxQuantity;

    @Column(nullable = false)
    private Integer stockQuantity;

    @Column(nullable = false)
    private Integer safetyStock;

    @Column(nullable = false)
    private Integer leadTimeDays;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private ProductStatus status;

    @Column(length = 1000)
    private String description;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vendor_id")
    private Vendor vendor;

    @Builder
    public Product(String productCode, String name, String category, Long unitPrice,
                   Integer boxQuantity, Integer stockQuantity, Integer safetyStock,
                   Integer leadTimeDays, ProductStatus status, String description, Vendor vendor) {
        this.productCode = productCode;
        this.name = name;
        this.category = category;
        this.unitPrice = unitPrice;
        this.boxQuantity = boxQuantity;
        this.stockQuantity = stockQuantity;
        this.safetyStock = safetyStock;
        this.leadTimeDays = leadTimeDays;
        this.status = status;
        this.description = description;
        this.vendor = vendor;
    }

    public void update(String name, String category, Long unitPrice, Integer boxQuantity,
                       Integer stockQuantity, Integer safetyStock, Integer leadTimeDays,
                       ProductStatus status, String description, Vendor vendor) {
        this.name = name;
        this.category = category;
        this.unitPrice = unitPrice;
        this.boxQuantity = boxQuantity;
        this.stockQuantity = stockQuantity;
        this.safetyStock = safetyStock;
        this.leadTimeDays = leadTimeDays;
        this.status = status;
        this.description = description;
        this.vendor = vendor;
    }

    public void changeStatus(ProductStatus status) {
        this.status = status;
    }
}
