package com.fourweekdays.fourweekdays.tasks.model.dto.request;

import jakarta.validation.constraints.NotBlank;

public record TaskPickingWorderAssignRequest(
        @NotBlank(message = "작업자는 필수입니다.")
        Long worderId,

        String note
) {
}
