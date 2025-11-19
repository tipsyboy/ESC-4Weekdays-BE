package com.fourweekdays.fourweekdays.inventory.model.dto.response;

import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import com.fourweekdays.fourweekdays.inventory.model.entity.InventoryDocument;
import com.fourweekdays.fourweekdays.product.model.entity.Product;

import java.util.List;


public record ProductInventoryResponse(
        Long productId,
        String productCode,
        String productName,
        long unitPrice,
        String vendorName,
        int totalQuantity,
        long totalPrice,
        List<ProductInventoryDetailResponse> inventories
) {
    // 기존 DB 엔티티용
    public static ProductInventoryResponse from(Product product, List<Inventory> inventories) {
        int totalQuantity = inventories.stream()
                .mapToInt(Inventory::getQuantity)
                .sum();

        long totalPrice = totalQuantity * product.getUnitPrice();

        return new ProductInventoryResponse(
                product.getId(),
                product.getProductCode(),
                product.getName(),
                product.getUnitPrice(),
                product.getVendor().getName(),
                totalQuantity,
                totalPrice,
                inventories.stream()
                        .map(ProductInventoryDetailResponse::from)
                        .toList()
        );
    }

    // ES Document용
    public static ProductInventoryResponse from(List<InventoryDocument> inventories) {
        if (inventories == null || inventories.isEmpty()) {
            return null;
        }

        // 첫 번째 Inventory에서 Product 정보 추출
        InventoryDocument first = inventories.get(0);

        int totalQuantity = inventories.stream()
                .mapToInt(inv -> inv.getQuantity() != null ? inv.getQuantity().intValue() : 0)
                .sum();

        long totalPrice = totalQuantity * (first.getUnitPrice() != null ? first.getUnitPrice() : 0L);

        return new ProductInventoryResponse(
                first.getProductId(),
                first.getProductCode(),
                first.getProductName(),
                first.getUnitPrice() != null ? first.getUnitPrice() : 0L,
                first.getVendorName(),
                totalQuantity,
                totalPrice,
                inventories.stream()
                        .map(ProductInventoryDetailResponse::from)
                        .toList()
        );
    }
}
