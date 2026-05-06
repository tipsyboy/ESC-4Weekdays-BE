package com.fourweekdays.fourweekdays.purchaseorder.repository;

import static com.fourweekdays.fourweekdays.product.domain.QProduct.product;
import static com.fourweekdays.fourweekdays.purchaseorder.model.entity.QPurchaseOrder.purchaseOrder;
import static com.fourweekdays.fourweekdays.purchaseorder.model.entity.QPurchaseOrderProduct.purchaseOrderProduct;
import static com.fourweekdays.fourweekdays.vendor.domain.QVendor.vendor;

import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class PurchaseOrderQueryRepositoryImpl implements PurchaseOrderQueryRepository {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<PurchaseOrder> search(
            String vendorName,
            String requesterName,
            PurchaseOrderStatus status,
            LocalDate expectedInboundDate,
            String approverName,
            String purchaseOrderNumber,
            String memoKeyword,
            Pageable pageable
    ) {
        List<Long> ids = queryFactory
                .select(purchaseOrder.id)
                .from(purchaseOrder)
                .join(purchaseOrder.vendor, vendor)
                .where(
                        containsVendorName(vendorName),
                        containsRequesterName(requesterName),
                        eqStatus(status),
                        eqExpectedInboundDate(expectedInboundDate),
                        containsApproverName(approverName),
                        containsPurchaseOrderNumber(purchaseOrderNumber),
                        containsMemoKeyword(memoKeyword)
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(PurchaseOrderQuerySortUtils.toOrderSpecifiers(pageable.getSort()))
                .fetch();

        if (ids.isEmpty()) {
            return PageableExecutionUtils.getPage(List.of(), pageable, () -> 0L);
        }

        List<PurchaseOrder> content = queryFactory
                .selectFrom(purchaseOrder)
                .distinct()
                .join(purchaseOrder.vendor, vendor).fetchJoin()
                .leftJoin(purchaseOrder.products, purchaseOrderProduct).fetchJoin()
                .leftJoin(purchaseOrderProduct.product, product).fetchJoin()
                .where(purchaseOrder.id.in(ids))
                .fetch();

        content.sort(Comparator.comparingInt(order -> ids.indexOf(order.getId())));

        return PageableExecutionUtils.getPage(
                content,
                pageable,
                () -> {
                    Long count = queryFactory
                            .select(purchaseOrder.count())
                            .from(purchaseOrder)
                            .join(purchaseOrder.vendor, vendor)
                            .where(
                                    containsVendorName(vendorName),
                                    containsRequesterName(requesterName),
                                    eqStatus(status),
                                    eqExpectedInboundDate(expectedInboundDate),
                                    containsApproverName(approverName),
                                    containsPurchaseOrderNumber(purchaseOrderNumber),
                                    containsMemoKeyword(memoKeyword)
                            )
                            .fetchOne();
                    return count != null ? count : 0L;
                }
        );
    }

    private BooleanExpression containsVendorName(String vendorName) {
        return hasText(vendorName) ? vendor.name.containsIgnoreCase(vendorName.trim()) : null;
    }

    private BooleanExpression containsRequesterName(String requesterName) {
        return hasText(requesterName) ? purchaseOrder.requesterName.containsIgnoreCase(requesterName.trim()) : null;
    }

    private BooleanExpression eqStatus(PurchaseOrderStatus status) {
        return status != null ? purchaseOrder.status.eq(status) : null;
    }

    private BooleanExpression eqExpectedInboundDate(LocalDate expectedInboundDate) {
        return expectedInboundDate != null ? purchaseOrder.expectedInboundDate.eq(expectedInboundDate) : null;
    }

    private BooleanExpression containsApproverName(String approverName) {
        return hasText(approverName) ? purchaseOrder.approverName.containsIgnoreCase(approverName.trim()) : null;
    }

    private BooleanExpression containsPurchaseOrderNumber(String purchaseOrderNumber) {
        return hasText(purchaseOrderNumber) ? purchaseOrder.purchaseOrderNumber.containsIgnoreCase(purchaseOrderNumber.trim()) : null;
    }

    private BooleanExpression containsMemoKeyword(String memoKeyword) {
        return hasText(memoKeyword) ? purchaseOrder.requestMemo.containsIgnoreCase(memoKeyword.trim()) : null;
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }
}
