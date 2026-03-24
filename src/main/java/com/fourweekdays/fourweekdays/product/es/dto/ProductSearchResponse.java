package com.fourweekdays.fourweekdays.product.es.dto;

import com.fourweekdays.fourweekdays.product.es.ProductDocument;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;

public record ProductSearchResponse(
        Long productId,
        String productCode,
        String name,
        Long unitPrice,
        ProductStatus status,
        Long vendorId,
        String vendorName
) {

    public static ProductSearchResponse from(ProductDocument document) {
        return new ProductSearchResponse(
                document.getProductId(),
                document.getProductCode(),
                document.getName(),
                document.getUnitPrice(),
                document.getStatus(),
                document.getVendorId(),
                document.getVendorName()
        );
    }
}
