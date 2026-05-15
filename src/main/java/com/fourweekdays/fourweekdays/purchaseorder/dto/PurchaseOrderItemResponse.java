package com.fourweekdays.fourweekdays.purchaseorder.dto;

import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderItem;

public record PurchaseOrderItemResponse(
        Long productId,
        String productCode,
        String productName,
        Integer orderQuantity,
        Long orderUnitPrice,
        Long lineAmount
) {
    public static PurchaseOrderItemResponse from(PurchaseOrderItem item) {
        long lineAmount = (long) item.getOrderQuantity() * item.getOrderUnitPrice();

        return new PurchaseOrderItemResponse(
                item.getProduct().getId(),
                item.getProduct().getProductCode(),
                item.getProduct().getName(),
                item.getOrderQuantity(),
                item.getOrderUnitPrice(),
                lineAmount
        );
    }
}
