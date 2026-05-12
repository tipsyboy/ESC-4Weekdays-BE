package com.fourweekdays.fourweekdays.inventory.dto;

import com.fourweekdays.fourweekdays.inventory.domain.Inventory;
import com.fourweekdays.fourweekdays.inventory.domain.InventoryStatus;
import com.fourweekdays.fourweekdays.product.domain.Product;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;

public record InventoryListResponse(
        Long id,
        Long productId,
        String productCode,
        String productName,
        String vendorName,
        Integer totalQuantity,
        Integer availableQuantity,
        Integer holdQuantity,
        Integer safetyStock,
        InventoryStatus status,
        Integer locationCount,
        Long lastInboundId,
        String lastInboundCode,
        LocalDateTime lastInboundAt
) {
    public static InventoryListResponse from(Product product, List<Inventory> inventories) {
        int totalQuantity = inventories.stream().mapToInt(Inventory::getQuantity).sum();
        int availableQuantity = inventories.stream().mapToInt(Inventory::getAvailableQuantity).sum();
        int holdQuantity = inventories.stream().mapToInt(Inventory::getHoldQuantity).sum();

        Inventory latestInventory = inventories.stream()
                .filter(inventory -> inventory.getLastInboundAt() != null)
                .max(Comparator.comparing(Inventory::getLastInboundAt))
                .orElse(null);

        return new InventoryListResponse(
                product.getId(),
                product.getId(),
                product.getProductCode(),
                product.getName(),
                product.getVendor().getName(),
                totalQuantity,
                availableQuantity,
                holdQuantity,
                product.getSafetyStock(),
                InventoryStatusCalculator.calculate(totalQuantity, availableQuantity, product.getSafetyStock()),
                inventories.size(),
                latestInventory != null && latestInventory.getLastInbound() != null ? latestInventory.getLastInbound().getId() : null,
                latestInventory != null && latestInventory.getLastInbound() != null ? latestInventory.getLastInbound().getInboundNumber() : null,
                latestInventory != null ? latestInventory.getLastInboundAt() : null
        );
    }
}
