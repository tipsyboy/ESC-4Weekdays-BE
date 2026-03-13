package com.fourweekdays.fourweekdays.product;

import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.querydsl.core.annotations.QueryProjection;

import java.time.LocalDateTime;

public class ProductOptimizedDto {

    private Long id;
    private String productCode;
    private String productName;
    private String vendorName;
    private Long unitPrice;
    private ProductStatus status;
    private Integer vendorProductCount;
    private LocalDateTime createdAt;

    public ProductOptimizedDto() {
    }

    @QueryProjection
    public ProductOptimizedDto(Long id, String productCode, String productName, String vendorName, 
                               Long unitPrice, ProductStatus status, Integer vendorProductCount, 
                               LocalDateTime createdAt) {
        this.id = id;
        this.productCode = productCode;
        this.productName = productName;
        this.vendorName = vendorName;
        this.unitPrice = unitPrice;
        this.status = status;
        this.vendorProductCount = vendorProductCount;
        this.createdAt = createdAt;
    }

    public Long getId() {
        return id;
    }

    public String getProductCode() {
        return productCode;
    }

    public String getProductName() {
        return productName;
    }

    public String getVendorName() {
        return vendorName;
    }

    public Long getUnitPrice() {
        return unitPrice;
    }

    public ProductStatus getStatus() {
        return status;
    }

    public Integer getVendorProductCount() {
        return vendorProductCount;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
}
