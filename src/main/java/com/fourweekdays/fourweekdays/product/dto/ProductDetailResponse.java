package com.fourweekdays.fourweekdays.product.dto;

import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.product.domain.ProductStatus;
import java.time.LocalDateTime;

public record ProductDetailResponse(
        Long id,
        String productCode,
        String name,
        Long vendorId,
        String vendorName,
        String category,
        Long unitPrice,
        Integer boxQuantity,
        Integer stockQuantity,
        Integer safetyStock,
        ProductStatus status,
        String description,
        Integer leadTimeDays,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static ProductDetailResponse from(Product product) {
        return new ProductDetailResponse(
                product.getId(),
                product.getProductCode(),
                product.getName(),
                product.getVendor().getId(),
                product.getVendor().getName(),
                product.getCategory(),
                product.getUnitPrice(),
                product.getBoxQuantity(),
                product.getStockQuantity(),
                product.getSafetyStock(),
                product.getStatus(),
                product.getDescription(),
                product.getLeadTimeDays(),
                product.getCreatedAt(),
                product.getUpdatedAt()
        );
    }
}
