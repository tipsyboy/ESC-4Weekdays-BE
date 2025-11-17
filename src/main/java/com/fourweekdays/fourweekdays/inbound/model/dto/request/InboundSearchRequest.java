package com.fourweekdays.fourweekdays.inbound.model.dto.request;

import java.util.List;

public record InboundSearchRequest(
        String inboundCode,
        String managerName,
        String productName,
        List<Long> vendorIds
) {
}
