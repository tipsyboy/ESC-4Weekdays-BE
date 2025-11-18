package com.fourweekdays.fourweekdays.inventory.model.dto.request;

import java.time.LocalDate;

public record InventorySearchRequest(
        String productName,
        String productCode,
        String productStatus,
        String vendorName,
        Long minQuantity,
        Long maxQuantity,
        Long minPrice,
        Long maxPrice,
        String lotNumber,
        String locationCode,
        String inboundCode,
        LocalDate inboundDateFrom,
        LocalDate inboundDateTo,
        LocalDate createdFrom,
        LocalDate createdTo
) {
}