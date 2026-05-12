package com.fourweekdays.fourweekdays.inventory.dto;

import com.fourweekdays.fourweekdays.inventory.domain.InventoryStatus;

public final class InventoryStatusCalculator {

    private InventoryStatusCalculator() {
    }

    public static InventoryStatus calculate(Integer quantity, Integer availableQuantity, Integer safetyStock) {
        int currentQuantity = quantity != null ? quantity : 0;
        int currentAvailableQuantity = availableQuantity != null ? availableQuantity : 0;
        int currentSafetyStock = safetyStock != null ? safetyStock : 0;

        if (currentQuantity == 0) {
            return InventoryStatus.OUT;
        }

        if (currentAvailableQuantity <= currentSafetyStock) {
            return InventoryStatus.LOW;
        }

        return InventoryStatus.NORMAL;
    }
}
