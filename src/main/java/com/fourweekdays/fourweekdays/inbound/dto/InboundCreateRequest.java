package com.fourweekdays.fourweekdays.inbound.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record InboundCreateRequest(
        @NotNull(message = "ASN을 선택해주세요.")
        Long asnId,

        @NotBlank(message = "도크를 입력해주세요.")
        String dock,

        String inboundMemo
) {
}
