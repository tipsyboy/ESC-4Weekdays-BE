package com.fourweekdays.fourweekdays.purchaseorder.dto;

import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import java.time.LocalDate;

public record PurchaseOrderSearchCondition(
        Integer page,
        Integer size,
        String vendorName,
        String requesterName,
        PurchaseOrderStatus status,
        LocalDate expectedInboundDate,
        String approverName,
        String purchaseOrderNumber,
        String memoKeyword,
        String sortBy,
        String sortDirection
) {

    public int pageOrDefault() {
        return page == null ? 0 : page;
    }

    public int sizeOrDefault() {
        return size == null ? 8 : size;
    }

    public String sortByOrDefault() {
        return sortBy == null ? "updatedAt" : sortBy;
    }

    public String sortDirectionOrDefault() {
        return sortDirection == null ? "desc" : sortDirection;
    }
}
