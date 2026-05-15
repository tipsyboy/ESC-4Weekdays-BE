package com.fourweekdays.fourweekdays.inventory.dto;

import com.fourweekdays.fourweekdays.inventory.domain.Inventory;
import com.fourweekdays.fourweekdays.inventory.domain.InventoryStatus;
import com.fourweekdays.fourweekdays.product.domain.Product;
import java.util.Comparator;
import java.util.List;

public record InventoryDetailResponse(
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
        List<InventoryStockResponse> stocks
) {
    public static InventoryDetailResponse from(Product product, List<Inventory> inventories) {
        int totalQuantity = inventories.stream().mapToInt(Inventory::getQuantity).sum();
        int availableQuantity = inventories.stream().mapToInt(Inventory::getAvailableQuantity).sum();
        int holdQuantity = inventories.stream().mapToInt(Inventory::getHoldQuantity).sum();

        return new InventoryDetailResponse(
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
                inventories.stream()
                        .sorted(Comparator.comparing(inventory -> inventory.getLocation().getLocationCode()))
                        .map(InventoryStockResponse::from)
                        .toList()
        );
    }
}
