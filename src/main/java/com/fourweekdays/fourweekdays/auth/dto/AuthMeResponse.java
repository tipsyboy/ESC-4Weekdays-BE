package com.fourweekdays.fourweekdays.auth.dto;

import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;

public record AuthMeResponse(
        Long id,
        String email,
        String name,
        MemberRole role
) {
    public static AuthMeResponse from(Member member) {
        return new AuthMeResponse(
                member.getId(),
                member.getEmail(),
                member.getName(),
                member.getRole()
        );
    }
}
