package com.fourweekdays.fourweekdays.asn.dto;

import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.List;

public record AsnCreateRequest(
        @NotNull(message = "발주서를 선택해주세요.")
        Long purchaseOrderId,

        LocalDateTime expectedArrivalAt,

        @NotNull(message = "ASN 상태를 선택해주세요.")
        AsnStatus status,

        String vehicleInfo,

        String contactName,

        String contactPhoneNumber,

        String note,

        @Valid
        List<AsnCreateItemRequest> items
) {
}
