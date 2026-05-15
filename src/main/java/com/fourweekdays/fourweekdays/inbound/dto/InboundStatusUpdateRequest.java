package com.fourweekdays.fourweekdays.inbound.dto;

import com.fourweekdays.fourweekdays.inbound.domain.InboundStatus;

public record InboundStatusUpdateRequest(InboundStatus status) { }
