package com.fourweekdays.fourweekdays.vendor.model.dto.request;

import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class VendorCreateDto {
    private String businessRegistrationNo;
    private String name;
    private String phoneNumber;
    private String email;
    private String address;

    public Vendor toEntity() {
        return Vendor.builder()
                .businessRegistrationNo(this.businessRegistrationNo)
                .name(this.name)
                .phoneNumber(this.phoneNumber)
                .email(this.email)
//                .address()
                .build();
    }
}
