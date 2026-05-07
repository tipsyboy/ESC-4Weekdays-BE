package com.fourweekdays.fourweekdays.auth.dto;

import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;

public record AuthMeResponse(
        Long id,
        String email,
        String name,
        MemberRole role,
        Long vendorId,
        String vendorName
) {
    public static AuthMeResponse from(Member member) {
        return new AuthMeResponse(
                member.getId(),
                member.getEmail(),
                member.getName(),
                member.getRole(),
                member.getVendor() != null ? member.getVendor().getId() : null,
                member.getVendor() != null ? member.getVendor().getName() : null
        );
    }
}
