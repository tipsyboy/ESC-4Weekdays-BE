package com.fourweekdays.fourweekdays.vendor.dto;

import com.fourweekdays.fourweekdays.vendor.domain.VendorStatus;

public record VendorSearchCondition(
        Integer page,
        Integer size,
        VendorStatus status,
        String name,
        String vendorCode,
        String managerName,
        String phoneNumber,
        String email,
        String sortBy,
        String sortDirection
) {
    public int pageOrDefault() {
        return page == null ? 0 : page;
    }

    public int sizeOrDefault() {
        return size == null ? 10 : size;
    }

    public String sortByOrDefault() {
        return sortBy == null || sortBy.isBlank() ? "updatedAt" : sortBy;
    }

    public String sortDirectionOrDefault() {
        return sortDirection == null || sortDirection.isBlank() ? "desc" : sortDirection;
    }
}
