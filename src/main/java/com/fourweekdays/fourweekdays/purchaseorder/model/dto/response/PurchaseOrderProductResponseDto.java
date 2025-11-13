package com.fourweekdays.fourweekdays.purchaseorder.model.dto.response;

import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderProduct;
import lombok.Builder;

@Builder
public record PurchaseOrderProductResponseDto(
        Long id,
        String productCode,
        Long productId,
        String productName,
        Long unitPrice,
        Long totalPrice,
        Integer orderedQuantity,
        String description
) {
    public static PurchaseOrderProductResponseDto toDto(PurchaseOrderProduct item) {
        Product product = item.getProduct();
        return PurchaseOrderProductResponseDto.builder()
                .id(item.getId())
                .productId(product.getId())
                .productCode(product.getProductCode())
                .productName(product.getName())
                .unitPrice(product.getUnitPrice())
                .totalPrice(product.getUnitPrice() * item.getOrderedQuantity())
                .orderedQuantity(item.getOrderedQuantity())
                .description(item.getDescription())
                .build();
    }
}