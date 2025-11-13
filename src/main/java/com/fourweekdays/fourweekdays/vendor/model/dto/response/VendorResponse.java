package com.fourweekdays.fourweekdays.vendor.model.dto.response;

import com.fourweekdays.fourweekdays.common.vo.Address;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class VendorResponse {
    private String vendorCode; // 공급업체 코드 (V-001, V-002 등)
    private String name;
    private String phoneNumber;
    private String email;
    private VendorStatus status; // ACTIVE, INACTIVE, SUSPEND
    private Address address;

    public static VendorResponse from(Vendor vendor) {
        return VendorResponse.builder()
                .vendorCode(vendor.getVendorCode())
                .name(vendor.getName())
                .phoneNumber(vendor.getPhoneNumber())
                .email(vendor.getEmail())
                .status(vendor.getStatus())
                .address(vendor.getAddress())
                .build();
    }
}