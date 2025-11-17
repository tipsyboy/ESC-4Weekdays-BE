package com.fourweekdays.fourweekdays.product.model.dto.request;

import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;

// TODO: 가격 from - to 조건 추가,
public record ProductSearchRequest(
        String productCode,
        String productName,
        ProductStatus status,

        String vendorName
) {
}

