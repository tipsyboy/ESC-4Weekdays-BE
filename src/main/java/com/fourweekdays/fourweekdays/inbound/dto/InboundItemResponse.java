package com.fourweekdays.fourweekdays.inbound.dto;

import com.fourweekdays.fourweekdays.inbound.domain.InboundProduct;

public record InboundItemResponse(
        Long productId,
        String productCode,
        String productName,
        Long locationId,
        String locationCode,
        String locationDisplayName,
        Integer expectedQuantity,
        Integer receivedQuantity,
        Integer defectQuantity,
        String memo
) {
    public static InboundItemResponse from(InboundProduct item) {
        String locationCode = item.getLocation() != null
                ? item.getLocation().getLocationCode()
                : item.getLocationCode();

        return new InboundItemResponse(
                item.getProduct().getId(),
                item.getProduct().getProductCode(),
                item.getProduct().getName(),
                item.getLocation() != null ? item.getLocation().getId() : null,
                locationCode,
                locationCode,
                item.getExpectedQuantity(),
                item.getReceivedQuantity(),
                item.getDefectQuantity(),
                item.getMemo()
        );
    }
}
