package com.fourweekdays.fourweekdays.member.repository;

import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.member.domain.MemberStatus;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.time.LocalDate;
public interface MemberRepositoryCustom {

    Page<Member> findAllWithPaging(Pageable pageable);

    Page<Member> searchMembers(
            String name,
            String memberCode,
            String department,
            String loginId,
            MemberStatus status,
            MemberRole role,
            LocalDate fromDate,
            LocalDate toDate,
            Pageable pageable
    );
}
