package com.fourweekdays.fourweekdays.asn.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record AsnCreateItemRequest(
        @NotNull(message = "상품을 선택해주세요.")
        Long productId,

        @NotNull(message = "회신 수량을 입력해주세요.")
        @Min(value = 1, message = "회신 수량은 1 이상이어야 합니다.")
        Integer announcedQuantity
) {
}
