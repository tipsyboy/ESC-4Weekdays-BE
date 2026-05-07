package com.fourweekdays.fourweekdays.asn.repository;

import static com.fourweekdays.fourweekdays.asn.domain.QAsn.asn;

import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import com.fourweekdays.fourweekdays.asn.dto.AsnSummaryResponse;
import com.querydsl.core.Tuple;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.core.types.dsl.CaseBuilder;
import com.querydsl.core.types.dsl.NumberExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class AsnSummaryRepositoryImpl implements AsnSummaryRepository {

    private final JPAQueryFactory queryFactory;

    @Override
    public AsnSummaryResponse summarize(Long vendorId) {
        // 각 상태별 집계식을 먼저 변수로 잡아두면 select 결과에서 같은 expression으로 값을 꺼낼 수 있다.
        NumberExpression<Long> waitingCount = countByStatus(AsnStatus.WAITING);
        NumberExpression<Long> receivedCount = countByStatus(AsnStatus.RECEIVED);
        NumberExpression<Long> scheduledCount = countByStatus(AsnStatus.SCHEDULED);
        NumberExpression<Long> rejectedCount = countByStatus(AsnStatus.REJECTED);

        // ASN row 전체를 가져오지 않고 DB에서 total/status별 count 숫자만 계산한다.
        Tuple result = queryFactory
                .select(
                        asn.count(),
                        waitingCount,
                        receivedCount,
                        scheduledCount,
                        rejectedCount
                )
                .from(asn)
                .where(eqVendorId(vendorId))
                .fetchOne();

        // 집계 쿼리는 보통 결과 row가 1개 나오지만, 방어적으로 null을 기본 summary로 처리한다.
        if (result == null) {
            return new AsnSummaryResponse(0, 0, 0, 0, 0);
        }

        // QueryDSL Tuple은 select에 넣은 expression을 key처럼 사용해서 값을 꺼낸다.
        return new AsnSummaryResponse(
                valueOrZero(result.get(asn.count())),
                valueOrZero(result.get(waitingCount)),
                valueOrZero(result.get(receivedCount)),
                valueOrZero(result.get(scheduledCount)),
                valueOrZero(result.get(rejectedCount))
        );
    }

    private NumberExpression<Long> countByStatus(AsnStatus status) {
        // SQL의 sum(case when status = ? then 1 else 0 end) 형태를 QueryDSL로 표현한 조건부 count다.
        return new CaseBuilder()
                .when(asn.status.eq(status))
                .then(1L)
                .otherwise(0L)
                .sum()
                // SUM 결과가 null이면 0으로 대체한다. SQL COALESCE와 같은 의미다.
                .coalesce(0L);
    }

    private BooleanExpression eqVendorId(Long vendorId) {
        // QueryDSL where()는 null 조건을 무시한다. vendorId가 없으면 전체 ASN을 집계한다.
        return vendorId != null ? asn.purchaseOrder.vendor.id.eq(vendorId) : null;
    }

    private long valueOrZero(Long value) {
        // Tuple에서 꺼낸 값도 null일 수 있으므로 응답에는 항상 숫자를 넣는다.
        return value != null ? value : 0L;
    }
}
