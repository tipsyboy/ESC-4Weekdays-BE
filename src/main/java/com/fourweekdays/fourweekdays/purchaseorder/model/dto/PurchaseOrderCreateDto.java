package com.fourweekdays.fourweekdays.purchaseorder.model.dto;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
public class PurchaseOrderCreateDto {

    @NotNull(message = "공급업체를 선택해주세요")
    private Long vendorId;  // 공급업체 ID

    @NotNull(message = "발주일을 입력해주세요")
    private LocalDate issueDate;  // 발주일

    @NotNull(message = "입고 예정일을 입력해주세요")
    private LocalDate expectedDate;  // 입고 예정일

//    @NotEmpty(message = "품목을 최소 1개 이상 추가해주세요")
//    private List<PurchaseOrderItemDto> items;  // 품목 목록

}