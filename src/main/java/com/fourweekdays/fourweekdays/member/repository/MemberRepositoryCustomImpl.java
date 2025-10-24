package com.fourweekdays.fourweekdays.member.repository;

import com.fourweekdays.fourweekdays.announcement.model.entity.Announcement;
import com.fourweekdays.fourweekdays.announcement.model.entity.QAnnouncement;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.model.entity.QMember;
import com.fourweekdays.fourweekdays.member.repository.MemberRepositoryCustom;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.util.List;

import static com.fourweekdays.fourweekdays.announcement.model.entity.QAnnouncement.announcement;

@RequiredArgsConstructor
public class  MemberRepositoryCustomImpl implements MemberRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    public static final QMember member = new QMember("member");
    @Override
    public Page<Member> findAllWithPaging(Pageable pageable) {
        List<Member> content = queryFactory
                .selectFrom(member)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(member.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .select(member.count())
                .from(member)
                .fetchOne();

        return new PageImpl<>(content, pageable, total);
    }
}