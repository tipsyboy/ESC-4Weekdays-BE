package com.fourweekdays.fourweekdays.product.dto;

import com.fourweekdays.fourweekdays.product.domain.ProductStatus;
import jakarta.validation.constraints.NotNull;

public record ProductStatusUpdateRequest(
        @NotNull(message = "상태를 선택해주세요.")
        ProductStatus status
) {
}
