package com.fourweekdays.fourweekdays.vendor.model.dto.request;

import com.fourweekdays.fourweekdays.common.vo.Address;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter @NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder @AllArgsConstructor
public class VendorCreateDto {

    @NotNull(message = "업체명을 입력해주세요.")
    private String name;

    private String phoneNumber;
    private String email;
    private String description;
    private Address address;

    public Vendor toEntity(String vendorCode) {
        return Vendor.builder()
                .name(this.name)
                .vendorCode(vendorCode)
                .phoneNumber(this.phoneNumber)
                .email(this.email)
                .description(this.description)
                .address(this.address)
                .status(VendorStatus.ACTIVE) // 기본값: ACTIVE
                .build();
    }
}
