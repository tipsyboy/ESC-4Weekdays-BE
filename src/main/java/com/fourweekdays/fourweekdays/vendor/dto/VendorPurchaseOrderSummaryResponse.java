package com.fourweekdays.fourweekdays.vendor.dto;

import java.util.List;

public record VendorPurchaseOrderSummaryResponse(
        long totalCount,
        long noneCount,
        long doneCount,
        long rejectedCount
) {
    public static VendorPurchaseOrderSummaryResponse from(List<VendorPurchaseOrderListResponse> purchaseOrders) {
        long totalCount = purchaseOrders.size();
        long noneCount = purchaseOrders.stream().filter(item -> "NONE".equals(item.replyStatus())).count();
        long doneCount = purchaseOrders.stream().filter(item -> "DONE".equals(item.replyStatus())).count();
        long rejectedCount = purchaseOrders.stream().filter(item -> "REJECTED".equals(item.replyStatus())).count();

        return new VendorPurchaseOrderSummaryResponse(totalCount, noneCount, doneCount, rejectedCount);
    }
}
