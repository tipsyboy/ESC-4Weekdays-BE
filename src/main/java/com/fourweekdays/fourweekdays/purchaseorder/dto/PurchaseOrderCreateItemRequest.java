package com.fourweekdays.fourweekdays.purchaseorder.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record PurchaseOrderCreateItemRequest(
        @NotNull(message = "상품을 선택해주세요.")
        Long productId,

        @NotNull(message = "발주 수량을 입력해주세요.")
        @Min(value = 1, message = "발주 수량은 1 이상이어야 합니다.")
        Integer quantity,

        @NotNull(message = "발주 단가를 입력해주세요.")
        @Min(value = 0, message = "발주 단가는 0 이상이어야 합니다.")
        Long unitPrice
) {
}
