package com.fourweekdays.fourweekdays.vendor.model.dto.request;

public record VendorSearchRequest(
        String vendorCode,
        String vendorName,
        String productCode,
        String productName
) {}
