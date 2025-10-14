package com.fourweekdays.fourweekdays.product.dto.request;

import com.fourweekdays.fourweekdays.product.model.ProductStatus;
import lombok.Getter;

@Getter
public class ProductStatusUpdateDto {
    private ProductStatus status;
    private String changedBy;
}
