package com.fourweekdays.fourweekdays.inbound.dto;

import com.fourweekdays.fourweekdays.global.response.PageResponse;
import java.util.List;

public record InboundPageResponse(
        List<InboundListResponse> content,
        int page,
        int size,
        long totalElements,
        int totalPages,
        boolean hasNext,
        boolean hasPrevious,
        InboundSummaryResponse summary
) {
    public static InboundPageResponse from(PageResponse<InboundListResponse> page, InboundSummaryResponse summary) {
        return new InboundPageResponse(
                page.content(),
                page.page(),
                page.size(),
                page.totalElements(),
                page.totalPages(),
                page.hasNext(),
                page.hasPrevious(),
                summary
        );
    }
}
