package com.fourweekdays.fourweekdays.purchaseorder.model.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class PurchaseOrderProductRequestDto {

    @NotNull(message = "상품 ID를 입력하세요.")
    private Long productId;

    @NotNull(message = "발주 수량을 입력하세요.")
    @Min(value = 1, message = "발주 수량은 1개 이상이어야 합니다")
    private Integer orderedQuantity;

    @Size(max = 500, message = "비고는 500자 이하로 입력해주세요")
    private String description;
}