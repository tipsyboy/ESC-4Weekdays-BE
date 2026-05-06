package com.fourweekdays.fourweekdays.purchaseorder.dto;

import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDate;
import java.util.List;

public record PurchaseOrderCreateRequest(
        @NotNull(message = "공급업체를 선택해주세요.")
        Long vendorId,

        @NotBlank(message = "요청자를 입력해주세요.")
        String requesterName,

        LocalDate expectedInboundDate,

        String requestMemo,

        @NotNull(message = "발주 상태를 선택해주세요.")
        PurchaseOrderStatus status,

        @Valid
        @NotEmpty(message = "발주 상품을 1개 이상 추가해주세요.")
        List<PurchaseOrderCreateItemRequest> items
) {
}
