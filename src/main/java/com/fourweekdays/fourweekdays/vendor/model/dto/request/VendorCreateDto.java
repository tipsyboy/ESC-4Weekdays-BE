package com.fourweekdays.fourweekdays.vendor.model.dto.request;

import com.fourweekdays.fourweekdays.common.vo.Address;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class VendorCreateDto {

    private String name;
    private String phoneNumber;
    private String email;
    private String description;
    private Address address;


    public Vendor toEntity() {
        return Vendor.builder()
                .name(this.name)
                .phoneNumber(this.phoneNumber)
                .email(this.email)
                .description(this.description)
                .address(this.address)
                .build();
    }
}
