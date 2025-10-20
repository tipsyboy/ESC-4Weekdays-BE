package com.fourweekdays.fourweekdays.purchaseorder.model.dto.response;

import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderProduct;
import lombok.Builder;

@Builder
public record PurchaseOrderItemResponseDto(
        Long id,
        String productName,
        Integer orderedQuantity,
        String description
) {
    public static PurchaseOrderItemResponseDto toDto(PurchaseOrderProduct item) {
        return PurchaseOrderItemResponseDto.builder()
                .id(item.getId())
                .productName(item.getProduct().getName())
                .orderedQuantity(item.getOrderedQuantity())
                .description(item.getDescription())
                .build();
    }
}