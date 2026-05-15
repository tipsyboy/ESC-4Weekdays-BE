package com.fourweekdays.fourweekdays.member.dto;

import com.fourweekdays.fourweekdays.member.domain.MemberStatus;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberSignUpDto {

    private String memberCode;

    private String loginId;

    @NotBlank(message = "이메일 입력을 해주세요")
    @Pattern(regexp = "^[a-zA-Z0-9+-._]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$", message = "이메일 형식이 올바르지 않습니다.")
    private String email;

    @NotBlank(message = "비밀번호을 입력해 주세요")
    @Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*\\d).{8,}$", message = "비밀번호는 영문과 숫자를 포함하여 8자 이상이어야 합니다.")
    private String password;

    @NotBlank(message = "이름을 입력해주세요")
    private String name;

    private String department;

    @NotBlank(message = "핸드폰번호를 입력해 주세요")
    @Pattern(regexp = "^010-\\d{4}-\\d{4}$", message = "핸드폰번호 형식이 올바르지 않습니다.")
    private String phoneNumber;

    @NotNull(message = "권한을 선택해주세요")
    private MemberRole role;

    @NotNull(message = "상태를 선택해주세요")
    private MemberStatus status;

    private Long vendorId;

    private String note;
}
