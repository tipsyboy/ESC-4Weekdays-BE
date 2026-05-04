package com.fourweekdays.fourweekdays.member.dto;

import com.fourweekdays.fourweekdays.member.domain.MemberStatus;
import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberResponseDto {

    private Long id;
    private String memberCode;
    private String loginId;
    private String email;
    private String name;
    private String department;
    private String phoneNumber;
    private MemberRole role;
    private Long vendorId;
    private String vendorName;
    private String note;
    private LocalDateTime joinAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private MemberStatus status;

    public static MemberResponseDto from(Member member) {
        return MemberResponseDto.builder()
                .id(member.getId())
                .memberCode(member.getMemberCode())
                .loginId(member.getLoginId())
                .email(member.getEmail())
                .name(member.getName())
                .department(member.getDepartment())
                .phoneNumber(member.getPhoneNumber())
                .role(member.getRole())
                .vendorId(member.getVendor() != null ? member.getVendor().getId() : null)
                .vendorName(member.getVendor() != null ? member.getVendor().getName() : null)
                .note(member.getNote())
                .status(member.getStatus())
                .joinAt(member.getJoinAt())
                .createdAt(member.getCreatedAt())
                .updatedAt(member.getUpdatedAt())
                .build();
    }
}
