package com.fourweekdays.fourweekdays.asn.dto;

import com.fourweekdays.fourweekdays.asn.domain.AsnItem;

public record AsnItemResponse(
        Long productId,
        String productCode,
        String productName,
        Integer announcedQuantity
) {
    public static AsnItemResponse from(AsnItem item) {
        return new AsnItemResponse(
                item.getProduct().getId(),
                item.getProduct().getProductCode(),
                item.getProduct().getName(),
                item.getAnnouncedQuantity()
        );
    }
}
