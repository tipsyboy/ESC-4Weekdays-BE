package com.fourweekdays.fourweekdays.inventory.dto;

import com.fourweekdays.fourweekdays.inventory.domain.InventoryStatus;

public record InventorySearchCondition(
        String productCode,
        String productName,
        String locationCode,
        String zoneCode,
        InventoryStatus status
) {
}
