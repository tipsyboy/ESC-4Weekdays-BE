package com.fourweekdays.fourweekdays.inbound.dto;

import com.fourweekdays.fourweekdays.inbound.domain.InboundStatus;
import java.util.List;

public record InboundSummaryResponse(
        long totalCount,
        long plannedCount,
        long receivingCount,
        long partialCount,
        long completedCount
) {
    public static InboundSummaryResponse from(List<InboundListResponse> inbounds) {
        long totalCount = inbounds.size();
        long plannedCount = inbounds.stream().filter(item -> item.status() == InboundStatus.PLANNED).count();
        long receivingCount = inbounds.stream().filter(item -> item.status() == InboundStatus.RECEIVING).count();
        long partialCount = inbounds.stream().filter(item -> item.status() == InboundStatus.PARTIAL).count();
        long completedCount = inbounds.stream().filter(item -> item.status() == InboundStatus.COMPLETED).count();

        return new InboundSummaryResponse(totalCount, plannedCount, receivingCount, partialCount, completedCount);
    }
}
