package com.fourweekdays.fourweekdays.auth.service;

import com.fourweekdays.fourweekdays.auth.principal.LoginMember;
import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
public class AuthAccessService {

    public Member currentMemberOrNull() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !(authentication.getPrincipal() instanceof LoginMember loginMember)) {
            return null;
        }

        return loginMember.getMember();
    }

    public Long currentVendorIdForVendorManagerOrNull() {
        Member member = currentMemberOrNull();
        if (member == null || member.getRole() != MemberRole.VENDOR_MANAGER) {
            return null;
        }

        if (member.getVendor() == null) {
            throw new AccessDeniedException("공급업체 계정에 연결된 업체가 없습니다.");
        }

        return member.getVendor().getId();
    }

    public void assertVendorScope(Long vendorId) {
        Long currentVendorId = currentVendorIdForVendorManagerOrNull();
        if (currentVendorId == null) {
            return;
        }

        if (!currentVendorId.equals(vendorId)) {
            throw new AccessDeniedException("해당 업체 데이터에 접근할 수 없습니다.");
        }
    }
}
