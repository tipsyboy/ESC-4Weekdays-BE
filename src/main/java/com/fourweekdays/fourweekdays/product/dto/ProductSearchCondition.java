package com.fourweekdays.fourweekdays.product.dto;

import com.fourweekdays.fourweekdays.product.domain.ProductStatus;

public record ProductSearchCondition(
        Integer page,
        Integer size,
        String vendorName,
        String productCode,
        String productName,
        String category,
        ProductStatus status,
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
