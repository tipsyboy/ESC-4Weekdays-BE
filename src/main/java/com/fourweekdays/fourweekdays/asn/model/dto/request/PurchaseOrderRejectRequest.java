package com.fourweekdays.fourweekdays.asn.model.dto.request;

import java.time.LocalDateTime;

public record PurchaseOrderRejectRequest(
        String orderCode,
        String description
) {
}
