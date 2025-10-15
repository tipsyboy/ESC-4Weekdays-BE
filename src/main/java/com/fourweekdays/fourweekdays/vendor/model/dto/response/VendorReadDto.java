package com.fourweekdays.fourweekdays.vendor.model.dto.response;

import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class VendorReadDto {
    private Long id;
    private String businessRegistrationNo; // 사업자 등록 번호
    private String name;
    private String phoneNumber;
    private String email;
    private String address;

    public static VendorReadDto from(Vendor entity) {
        return  VendorReadDto.builder()
                .id(entity.getId())
                .businessRegistrationNo(entity.getBusinessRegistrationNo())
                .name(entity.getName())
                .phoneNumber(entity.getPhoneNumber())
                .email(entity.getEmail())
//                .address(entity.getAddress())
                .build();
    }
}
