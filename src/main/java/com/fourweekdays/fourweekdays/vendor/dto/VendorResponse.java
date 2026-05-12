package com.fourweekdays.fourweekdays.vendor.dto;

import com.fourweekdays.fourweekdays.global.vo.Address;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import com.fourweekdays.fourweekdays.vendor.domain.VendorStatus;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class VendorResponse {
    private String vendorCode; // 공급업체 코드 (V-001, V-002 등)
    private String name;
    private String managerName;
    private Long managerId;
    private String managerMemberName;
    private String phoneNumber;
    private String email;
    private VendorStatus status;
    private Address address;

    public static VendorResponse from(Vendor vendor) {
        return VendorResponse.builder()
                .vendorCode(vendor.getVendorCode())
                .name(vendor.getName())
                .managerName(vendor.getManagerName())
                .managerId(vendor.getManager() != null ? vendor.getManager().getId() : null)
                .managerMemberName(vendor.getManager() != null ? vendor.getManager().getName() : null)
                .phoneNumber(vendor.getPhoneNumber())
                .email(vendor.getEmail())
                .status(vendor.getStatus())
                .address(vendor.getAddress())
                .build();
    }
}
