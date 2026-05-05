package com.fourweekdays.fourweekdays.vendor.dto;

import com.fourweekdays.fourweekdays.global.vo.Address;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class VendorUpdateDto {

    @NotBlank(message = "업체명은 필수입니다")
    @Size(max = 200)
    private String name;

    @NotBlank(message = "담당자명은 필수입니다")
    @Size(max = 100)
    private String managerName;

    @Size(max = 20)
    private String phoneNumber;

    @Email
    @Size(max = 100)
    private String email;

    private String description;

    private Address address;
}
