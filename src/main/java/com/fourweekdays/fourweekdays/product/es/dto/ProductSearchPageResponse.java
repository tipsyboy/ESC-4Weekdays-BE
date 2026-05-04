package com.fourweekdays.fourweekdays.product.es.dto;

import java.util.List;

public record ProductSearchPageResponse(
        List<ProductSearchResponse> content,
        PageInfo page
) {
    public record PageInfo(
            int size,
            int number,
            long totalElements,
            int totalPages
    ) {
    }
}
