package com.fourweekdays.fourweekdays.vendor.dto;

import com.fourweekdays.fourweekdays.global.vo.Address;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import com.fourweekdays.fourweekdays.vendor.domain.VendorStatus;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter @NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder @AllArgsConstructor
public class VendorCreateDto {

    @NotNull(message = "업체명을 입력해주세요.")
    private String name;

    @NotNull(message = "담당자명을 입력해주세요.")
    private String managerName;

    private String phoneNumber;
    private String email;
    private String description;
    private Address address;

    public Vendor toEntity(String vendorCode) {
        return Vendor.builder()
                .name(this.name)
                .vendorCode(vendorCode)
                .managerName(this.managerName)
                .phoneNumber(this.phoneNumber)
                .email(this.email)
                .description(this.description)
                .address(this.address)
                .status(VendorStatus.PENDING)
                .build();
    }
}
