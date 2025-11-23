package com.fourweekdays.fourweekdays.tasks.model.dto.request;

import jakarta.validation.constraints.NotNull;

public record TaskPickingCompleteRequest(
        Long workerId,
        String note,
        String locationCode
) {
}
