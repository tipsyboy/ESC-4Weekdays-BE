package com.fourweekdays.fourweekdays.asn.repository;

import com.fourweekdays.fourweekdays.asn.model.entity.ASN;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.util.List;

import static com.fourweekdays.fourweekdays.asn.model.entity.QASN.aSN;

@RequiredArgsConstructor
public class ASNRepositoryCustomImpl implements ASNRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<ASN> findAllWithPaging(Pageable pageable) {

        List<ASN> result = queryFactory.selectFrom(aSN)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(aSN.createdAt.desc())
                .fetch();

        Long total = queryFactory.select(aSN.count())
                .from(aSN)
                .fetchOne();

        return new PageImpl<>(result, pageable, total);
    }
}
