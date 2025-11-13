package com.fourweekdays.fourweekdays.outbound.repository;

import com.fourweekdays.fourweekdays.outbound.model.entity.Outbound;
import com.fourweekdays.fourweekdays.outbound.model.entity.QOutbound;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class OutboundRepositoryCustomImpl implements OutboundRepositoryCustom {

    private final JPAQueryFactory queryFactory;
    private final QOutbound outbound = QOutbound.outbound;

    @Override
    public Page<Outbound> findAllWithPaging(Pageable pageable) {
        List<Outbound> outbounds = queryFactory
                .selectFrom(outbound)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(outbound.createdAt.desc())
                .fetch();
        Long total = queryFactory
                .select(outbound.count())
                .from(outbound)
                .fetchOne();
        return new PageImpl<>(outbounds, pageable, total);
    }
}
