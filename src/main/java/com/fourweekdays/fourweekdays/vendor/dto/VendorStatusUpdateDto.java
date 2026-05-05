package com.fourweekdays.fourweekdays.vendor.dto;

import com.fourweekdays.fourweekdays.vendor.domain.VendorStatus;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class VendorStatusUpdateDto {

    @NotNull(message = "상태 값은 필수입니다.")
    private VendorStatus status;

}
