package com.fourweekdays.fourweekdays.asn.model.dto.request;

import java.time.LocalDateTime;

public record AsnReceiveRequest(
        String orderCode,
        LocalDateTime expectedDate,
        String description
) {
}
