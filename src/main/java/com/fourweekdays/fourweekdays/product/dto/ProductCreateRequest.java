package com.fourweekdays.fourweekdays.product.dto;

import com.fourweekdays.fourweekdays.product.domain.ProductStatus;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record ProductCreateRequest(
        @NotNull(message = "공급업체를 선택해주세요.")
        Long vendorId,

        @NotBlank(message = "상품명을 입력해주세요.")
        String name,

        @NotBlank(message = "카테고리를 입력해주세요.")
        String category,

        @NotNull(message = "단가를 입력해주세요.")
        @Min(value = 0, message = "단가는 0 이상이어야 합니다.")
        Long unitPrice,

        @NotNull(message = "박스당 수량을 입력해주세요.")
        @Min(value = 1, message = "박스당 수량은 1 이상이어야 합니다.")
        Integer boxQuantity,

        @NotNull(message = "현재 재고를 입력해주세요.")
        @Min(value = 0, message = "현재 재고는 0 이상이어야 합니다.")
        Integer stockQuantity,

        @NotNull(message = "안전재고를 입력해주세요.")
        @Min(value = 0, message = "안전재고는 0 이상이어야 합니다.")
        Integer safetyStock,

        @NotNull(message = "리드타임을 입력해주세요.")
        @Min(value = 0, message = "리드타임은 0 이상이어야 합니다.")
        Integer leadTimeDays,

        @NotNull(message = "상태를 선택해주세요.")
        ProductStatus status,

        String description
) {
}
