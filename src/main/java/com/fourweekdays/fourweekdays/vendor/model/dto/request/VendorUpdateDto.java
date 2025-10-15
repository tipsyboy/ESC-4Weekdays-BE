package com.fourweekdays.fourweekdays.vendor.model.dto.request;

import com.fourweekdays.fourweekdays.common.vo.Address;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class VendorUpdateDto {

    @NotBlank(message = "업체명은 필수입니다")
    @Size(max = 200)
    private String name;

    @Size(max = 20)
    private String phoneNumber;

    @Email
    @Size(max = 100)
    private String email;

    private String description;

    @NotNull
    private VendorStatus status;

    private Address address;
}

