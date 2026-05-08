package com.fourweekdays.fourweekdays.inventory.model.dto.response;

import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import java.util.List;

public record InventoryMapLocationResponse(
        String locationCode,
        Long representativeProductId,
        String representativeProductName,
        int skuCount,
        int totalQuantity
) {
    public static InventoryMapLocationResponse from(List<Inventory> inventories) {
        Inventory representative = inventories.get(0);
        int totalQuantity = inventories.stream()
                .mapToInt(Inventory::getQuantity)
                .sum();

        return new InventoryMapLocationResponse(
                representative.getLocation().getLocationCode(),
                representative.getProduct().getId(),
                representative.getProduct().getName(),
                inventories.size(),
                totalQuantity
        );
    }
}
