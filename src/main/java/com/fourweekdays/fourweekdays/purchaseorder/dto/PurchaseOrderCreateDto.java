package com.fourweekdays.fourweekdays.purchaseorder.dto;

import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@NoArgsConstructor
public class PurchaseOrderCreateDto {

    @NotNull(message = "공급업체를 선택해주세요")
    private Long vendorId; // 공급업체 ID

    @NotNull(message = "입고 예정일을 입력해주세요")
    private LocalDateTime expectedDate; // 입고 예정일

    @NotEmpty(message = "발주 상품을 선택해주세요.")
    private List<PurchaseOrderItemRequestDto> items;

    @Size(max = 1000, message = "비고는 1000자 이내로 입력해주세요")
    private String description;
}