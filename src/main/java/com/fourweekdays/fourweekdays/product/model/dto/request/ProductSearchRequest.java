package com.fourweekdays.fourweekdays.product.model.dto.request;

import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import org.springframework.util.StringUtils;

import java.time.LocalDate;

public record ProductSearchRequest(
        String productCode,
        String productName,
        ProductStatus status,
        String vendorName,

        Long minPrice,
        Long maxPrice,

        LocalDate registeredFrom,
        LocalDate registeredTo
) {
    public ProductSearchRequest normalized() {
        return new ProductSearchRequest(
                trimToNull(productCode),
                trimToNull(productName),
                status,
                trimToNull(vendorName),
                minPrice,
                maxPrice,
                registeredFrom,
                registeredTo
        );
    }

    public boolean hasSearchCondition() {
        return StringUtils.hasText(productCode)
                || StringUtils.hasText(productName)
                || status != null
                || StringUtils.hasText(vendorName)
                || minPrice != null
                || maxPrice != null
                || registeredFrom != null
                || registeredTo != null;
    }

    private static String trimToNull(String value) {
        if (!StringUtils.hasText(value)) {
            return null;
        }
        return value.trim();
    }
}
