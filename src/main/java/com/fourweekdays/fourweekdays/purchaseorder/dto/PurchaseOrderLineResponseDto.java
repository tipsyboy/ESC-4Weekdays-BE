package com.fourweekdays.fourweekdays.purchaseorder.dto;

import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderItem;
import lombok.Builder;

@Builder
public record PurchaseOrderLineResponseDto(
        Long id,
        String productCode,
        Long productId,
        String productName,
        Long unitPrice,
        Long totalPrice,
        Integer orderedQuantity,
        String description
) {
    public static PurchaseOrderLineResponseDto toDto(PurchaseOrderItem item) {
        Product product = item.getProduct();
        return PurchaseOrderLineResponseDto.builder()
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