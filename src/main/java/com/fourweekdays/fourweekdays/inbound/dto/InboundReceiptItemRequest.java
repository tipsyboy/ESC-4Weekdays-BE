package com.fourweekdays.fourweekdays.inbound.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

public record InboundReceiptItemRequest(
        @NotNull(message = "상품을 선택해주세요.")
        Long productId,

        Long locationId,

        @NotNull(message = "실제 입고 수량을 입력해주세요.")
        @Min(value = 0, message = "실제 입고 수량은 0 이상이어야 합니다.")
        Integer receivedQuantity,

        @NotNull(message = "불량 수량을 입력해주세요.")
        @Min(value = 0, message = "불량 수량은 0 이상이어야 합니다.")
        Integer defectQuantity,

        String memo
) {
}
