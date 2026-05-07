package com.fourweekdays.fourweekdays.asn.dto;

import com.fourweekdays.fourweekdays.global.response.PageResponse;
import java.util.List;

public record AsnPageResponse(
        List<AsnListResponse> content,
        int page,
        int size,
        long totalElements,
        int totalPages,
        boolean hasNext,
        boolean hasPrevious,
        AsnSummaryResponse summary
) {
    public static AsnPageResponse from(PageResponse<AsnListResponse> page, AsnSummaryResponse summary) {
        return new AsnPageResponse(
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
