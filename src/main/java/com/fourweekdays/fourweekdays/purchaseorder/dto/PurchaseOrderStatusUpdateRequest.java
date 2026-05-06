package com.fourweekdays.fourweekdays.purchaseorder.dto;

import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import jakarta.validation.constraints.NotNull;

public record PurchaseOrderStatusUpdateRequest(
        @NotNull(message = "변경할 상태를 선택해주세요.")
        PurchaseOrderStatus status,

        String approverName,

        String approvalMemo
) {
}
