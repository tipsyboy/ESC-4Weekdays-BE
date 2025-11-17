package com.fourweekdays.fourweekdays.announcement.repository;


import com.fourweekdays.fourweekdays.announcement.model.dto.request.AnnouncementSearchDto;
import com.fourweekdays.fourweekdays.announcement.model.entity.Announcement;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import java.util.List;

import static com.fourweekdays.fourweekdays.announcement.model.entity.QAnnouncement.announcement;

@RequiredArgsConstructor
public class  AnnouncementRepositoryCustomImpl implements AnnouncementRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<Announcement> findAllWithPaging(Pageable pageable) {
        List<Announcement> content = queryFactory
                .selectFrom(announcement)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(announcement.pinned.desc(), announcement.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .select(announcement.count())
                .from(announcement)
                .fetchOne();

        return new PageImpl<>(content, pageable, total);
    }

    @Override
    public Page<Announcement> searchAnnouncement(AnnouncementSearchDto announcementSearchDto, Pageable pageable) {
        BooleanBuilder builder = new BooleanBuilder();

        if (StringUtils.hasText(announcementSearchDto.getTitle())) {
            builder.and(announcement.title.contains(announcementSearchDto.getTitle()));
        }

        if (announcementSearchDto.getStartDate() != null) {
            builder.and(announcement.createdAt.goe(announcementSearchDto.getStartDate().atStartOfDay()));
        }

        if (announcementSearchDto.getEndDate() != null) {
            builder.and(announcement.createdAt.loe(announcementSearchDto.getEndDate().plusDays(1).atStartOfDay()));
        }

        if (announcementSearchDto.getPinned() != null) {
            builder.and(announcement.pinned.eq(announcementSearchDto.getPinned()));
        }

        List<Announcement> content = queryFactory
                .selectFrom(announcement)
                .where(builder)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(announcement.pinned.desc(), announcement.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .select(announcement.count())
                .from(announcement)
                .where(builder)
                .fetchOne();

        return new PageImpl<>(content, pageable, total);
    }
}