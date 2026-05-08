package com.fourweekdays.fourweekdays.inbound.dto;

import com.fourweekdays.fourweekdays.inbound.domain.InboundStatus;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.List;

public record InboundReceiptUpdateRequest(
        @NotNull(message = "입고 상태를 선택해주세요.")
        InboundStatus status,

        LocalDateTime receivedAt,

        String inspectionMemo,

        @Valid
        @NotEmpty(message = "입고 상품은 1개 이상 있어야 합니다.")
        List<InboundReceiptItemRequest> items
) {
}
