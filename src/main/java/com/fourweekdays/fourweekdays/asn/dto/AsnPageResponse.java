package com.fourweekdays.fourweekdays.asn.dto;

import java.util.List;
import org.springframework.data.domain.Page;

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
    public static AsnPageResponse from(Page<AsnListResponse> page, AsnSummaryResponse summary) {
        return new AsnPageResponse(
                page.getContent(),
                page.getNumber(),
                page.getSize(),
                page.getTotalElements(),
                page.getTotalPages(),
                page.hasNext(),
                page.hasPrevious(),
                summary
        );
    }
}
