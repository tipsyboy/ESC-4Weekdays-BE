package com.fourweekdays.fourweekdays.inbound.repository;

import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.util.List;

import static com.fourweekdays.fourweekdays.inbound.model.entity.QInbound.inbound;

@RequiredArgsConstructor
public class InboundRepositoryCustomImpl implements InboundRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<Inbound> findAllWithPaging(Pageable pageable) {
        List<Inbound> inbounds = queryFactory
                .selectFrom(inbound)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(inbound.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .select(inbound.count())
                .from(inbound)
                .fetchOne();

        return new PageImpl<>(inbounds, pageable, total);
    }
}
