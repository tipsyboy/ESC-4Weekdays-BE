package com.fourweekdays.fourweekdays.asn.dto;

import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import jakarta.validation.constraints.NotNull;

public record AsnStatusUpdateRequest(
        @NotNull(message = "변경할 ASN 상태를 선택해주세요.")
        AsnStatus status
) {
}
