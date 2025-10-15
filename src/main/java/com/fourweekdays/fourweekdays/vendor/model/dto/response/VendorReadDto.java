package com.fourweekdays.fourweekdays.vendor.model.dto.response;

import com.fourweekdays.fourweekdays.common.vo.Address;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
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
    private String phoneNumber;
    private String email;
    private String description;
    private VendorStatus status;

    private Address address;
    private Integer productCount; // 공급 상품 수

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public static VendorReadDto from(Vendor vendor) {
        return VendorReadDto.builder()
                .id(vendor.getId())
                .vendorCode(vendor.getVendorCode())
                .name(vendor.getName())
                .phoneNumber(vendor.getPhoneNumber())
                .email(vendor.getEmail())
                .description(vendor.getDescription())
                .status(vendor.getStatus())
                .address(vendor.getAddress())
                .productCount(vendor.getProductList() != null ? vendor.getProductList().size() : 0)
                .createdAt(vendor.getCreatedAt())
                .updatedAt(vendor.getUpdatedAt())
                .build();
    }
}
