package com.fourweekdays.fourweekdays.inventory.dto;

import com.fourweekdays.fourweekdays.inventory.domain.Inventory;
import com.fourweekdays.fourweekdays.inventory.domain.InventoryStatus;
import java.time.LocalDateTime;

public record InventoryStockResponse(
        Long inventoryId,
        String warehouseCode,
        String zoneCode,
        String locationCode,
        String lotNumber,
        Integer quantity,
        Integer availableQuantity,
        Integer holdQuantity,
        InventoryStatus status,
        Long lastInboundId,
        String lastInboundCode,
        LocalDateTime lastInboundAt,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static InventoryStockResponse from(Inventory inventory) {
        return new InventoryStockResponse(
                inventory.getId(),
                inventory.getLocation().getWarehouseCode(),
                inventory.getLocation().getZoneCode(),
                inventory.getLocation().getLocationCode(),
                inventory.getLotNumber(),
                inventory.getQuantity(),
                inventory.getAvailableQuantity(),
                inventory.getHoldQuantity(),
                InventoryStatusCalculator.calculate(
                        inventory.getQuantity(),
                        inventory.getAvailableQuantity(),
                        inventory.getProduct().getSafetyStock()
                ),
                inventory.getLastInbound() != null ? inventory.getLastInbound().getId() : null,
                inventory.getLastInbound() != null ? inventory.getLastInbound().getInboundNumber() : null,
                inventory.getLastInboundAt(),
                inventory.getCreatedAt(),
                inventory.getUpdatedAt()
        );
    }
}
