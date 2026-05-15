package com.fourweekdays.fourweekdays.member.querydsl.condition;

import com.fourweekdays.fourweekdays.member.domain.MemberStatus;
import com.fourweekdays.fourweekdays.member.domain.MemberRole;
import com.fourweekdays.fourweekdays.member.domain.QMember;
import com.querydsl.core.BooleanBuilder;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
public class MemberPredicateBuilder {

    private static final QMember member = QMember.member;

    public static BooleanBuilder buildMemberPredicate(
            String name,
            String memberCode,
            String department,
            String loginId,
            MemberStatus status,
            MemberRole role,
            LocalDate fromDate,
            LocalDate toDate
    ) {
        BooleanBuilder builder = new BooleanBuilder();

        if (StringUtils.hasText(name))
            builder.and(member.name.containsIgnoreCase(name));

        if (StringUtils.hasText(memberCode))
            builder.and(member.memberCode.containsIgnoreCase(memberCode));

        if (StringUtils.hasText(department))
            builder.and(member.department.containsIgnoreCase(department));

        if (StringUtils.hasText(loginId))
            builder.and(member.loginId.containsIgnoreCase(loginId));

        if (status != null)
            builder.and(member.status.eq(status));

        if (role != null)
            builder.and(member.role.eq(role));

        if (fromDate != null)
            builder.and(member.joinAt.goe(fromDate.atStartOfDay()));

        if (toDate != null)
            builder.and(member.joinAt.loe(toDate.atTime(23, 59, 59)));

        return builder;

    }
}
