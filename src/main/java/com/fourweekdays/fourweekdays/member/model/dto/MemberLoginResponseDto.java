package com.fourweekdays.fourweekdays.member.model.dto;

import com.fourweekdays.fourweekdays.member.auth.principal.LoginMember;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.model.entity.MemberRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberLoginResponseDto {

    private Long id;
    private String email;
    private String name;
    private MemberRole role;

    public static MemberLoginResponseDto from(LoginMember loginMember) {
        Member member = loginMember.getMember();
        return MemberLoginResponseDto.builder()
                .id(member.getId())
                .email(member.getEmail())
                .name(member.getName())
                .role(member.getRole())
                .build();
    }
}
