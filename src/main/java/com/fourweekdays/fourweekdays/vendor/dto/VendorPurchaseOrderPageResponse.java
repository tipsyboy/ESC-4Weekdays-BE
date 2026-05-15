package com.fourweekdays.fourweekdays.vendor.dto;

import com.fourweekdays.fourweekdays.global.response.PageResponse;
import java.util.List;

public record VendorPurchaseOrderPageResponse(
        List<VendorPurchaseOrderListResponse> content,
        int page,
        int size,
        long totalElements,
        int totalPages,
        boolean hasNext,
        boolean hasPrevious,
        VendorPurchaseOrderSummaryResponse summary
) {
    public static VendorPurchaseOrderPageResponse from(
            PageResponse<VendorPurchaseOrderListResponse> page,
            VendorPurchaseOrderSummaryResponse summary
    ) {
        return new VendorPurchaseOrderPageResponse(
                page.content(),
                page.page(),
                page.size(),
                page.totalElements(),
                page.totalPages(),
                page.hasNext(),
                page.hasPrevious(),
                summary
        );
    }
}
