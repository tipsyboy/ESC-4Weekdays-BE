package com.fourweekdays.fourweekdays.vendor.dto;

import com.fourweekdays.fourweekdays.global.vo.Address;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import com.fourweekdays.fourweekdays.vendor.domain.VendorStatus;
import lombok.*;

import java.time.LocalDateTime;


@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class VendorReadDto {

    private Long id;
    private String vendorCode;
    private String name;
    private String managerName;
    private Long managerId;
    private String managerMemberName;
    private String phoneNumber;
    private String email;
    private String description;
    private VendorStatus status;

    private Address address;
    private Integer productCount; // 공급 상품 수

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public static VendorReadDto from(Vendor vendor) {
        return from(vendor, vendor.getProductList() != null ? vendor.getProductList().size() : 0);
    }

    public static VendorReadDto from(Vendor vendor, int productCount) {
        return VendorReadDto.builder()
                .id(vendor.getId())
                .vendorCode(vendor.getVendorCode())
                .name(vendor.getName())
                .managerName(vendor.getManagerName())
                .managerId(vendor.getManager() != null ? vendor.getManager().getId() : null)
                .managerMemberName(vendor.getManager() != null ? vendor.getManager().getName() : null)
                .phoneNumber(vendor.getPhoneNumber())
                .email(vendor.getEmail())
                .description(vendor.getDescription())
                .status(vendor.getStatus())
                .address(vendor.getAddress())
                .productCount(productCount)
                .createdAt(vendor.getCreatedAt())
                .updatedAt(vendor.getUpdatedAt())
                .build();
    }
}
