package com.fourweekdays.fourweekdays.auth.principal;

import com.fourweekdays.fourweekdays.member.domain.Member;
import org.springframework.util.StringUtils;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;

@Getter
@RequiredArgsConstructor
public class LoginMember implements UserDetails {

    private final Member member;

    @Override
    public String getUsername() {
        return StringUtils.hasText(member.getLoginId()) ? member.getLoginId() : member.getEmail();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singleton(new SimpleGrantedAuthority(member.getRole().name()));
    }

    @Override
    public String getPassword() {
        return member.getPassword();
    }
}
