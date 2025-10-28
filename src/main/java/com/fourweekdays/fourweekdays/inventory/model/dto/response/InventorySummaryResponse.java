package com.fourweekdays.fourweekdays.inventory.model.dto.response;

import lombok.Builder;

@Builder
public record InventorySummaryResponse(
        Long productId,
        String productCode,
        String productName,
        Integer totalQuantity,
        String vendorName
) {
}
