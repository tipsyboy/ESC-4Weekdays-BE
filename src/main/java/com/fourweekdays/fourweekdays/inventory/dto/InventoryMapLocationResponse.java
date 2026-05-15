package com.fourweekdays.fourweekdays.inventory.dto;

import com.fourweekdays.fourweekdays.inventory.domain.Inventory;
import com.fourweekdays.fourweekdays.inventory.domain.InventoryStatus;
import java.util.Comparator;
import java.util.List;

public record InventoryMapLocationResponse(
        String warehouseCode,
        String zoneCode,
        String locationCode,
        Integer skuCount,
        Integer totalQuantity,
        Integer availableQuantity,
        Integer holdQuantity,
        InventoryStatus status,
        Long representativeProductId,
        String representativeProductName
) {
    public static InventoryMapLocationResponse from(List<Inventory> inventories) {
        Inventory representative = inventories.stream()
                .max(Comparator.comparing(Inventory::getAvailableQuantity))
                .orElseThrow();

        int totalQuantity = inventories.stream().mapToInt(Inventory::getQuantity).sum();
        int availableQuantity = inventories.stream().mapToInt(Inventory::getAvailableQuantity).sum();
        int holdQuantity = inventories.stream().mapToInt(Inventory::getHoldQuantity).sum();
        int safetyStock = inventories.stream()
                .map(Inventory::getProduct)
                .mapToInt(product -> product.getSafetyStock() != null ? product.getSafetyStock() : 0)
                .sum();

        return new InventoryMapLocationResponse(
                representative.getLocation().getWarehouseCode(),
                representative.getLocation().getZoneCode(),
                representative.getLocation().getLocationCode(),
                inventories.size(),
                totalQuantity,
                availableQuantity,
                holdQuantity,
                InventoryStatusCalculator.calculate(totalQuantity, availableQuantity, safetyStock),
                representative.getProduct().getId(),
                representative.getProduct().getName()
        );
    }
}
