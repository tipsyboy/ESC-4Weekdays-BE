package com.fourweekdays.fourweekdays.inbound.repository;

import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import java.util.List;

import static com.fourweekdays.fourweekdays.inbound.model.entity.QInbound.inbound;
import static com.fourweekdays.fourweekdays.inbound.model.entity.QInboundProduct.inboundProduct;
import static com.fourweekdays.fourweekdays.product.model.entity.QProduct.product;
import static com.fourweekdays.fourweekdays.purchaseorder.model.entity.QPurchaseOrder.purchaseOrder;
import static com.fourweekdays.fourweekdays.vendor.model.entity.QVendor.vendor;

@Repository
@RequiredArgsConstructor
public class InboundRepositoryCustomImpl implements InboundRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<Inbound> searchInboundWithProduct(Pageable pageable, String inboundCode,
                                                  String productName, String managerName, List<Long> vendorIds) {
        List<Inbound> results = queryFactory
                .selectDistinct(inbound)
                .from(inbound)
                .leftJoin(inbound.products, inboundProduct)
                .leftJoin(inboundProduct.product, product)
                .leftJoin(inbound.purchaseOrder, purchaseOrder).fetchJoin()
                .leftJoin(purchaseOrder.vendor, vendor).fetchJoin()
                .where(
                        inboundCodeContains(inboundCode),
                        managerNameLike(managerName),
                        productNameLike(productName),
                        vendorIdsIn(vendorIds)
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(inbound.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .selectDistinct(inbound.count())
                .from(inbound)
                .leftJoin(inbound.products, inboundProduct)
                .leftJoin(inboundProduct.product, product)
                .leftJoin(inbound.purchaseOrder, purchaseOrder)
                .leftJoin(purchaseOrder.vendor, vendor)
                .where(
                        inboundCodeContains(inboundCode),
                        managerNameLike(managerName),
                        productNameLike(productName),
                        vendorIdsIn(vendorIds)
                )
                .fetchOne();

        return new PageImpl<>(results, pageable, total != null ? total : 0L);
    }

    private BooleanExpression inboundCodeContains(String code) {
        return StringUtils.hasText(code) ? inbound.inboundCode.containsIgnoreCase(code) : null;
    }

    private BooleanExpression managerNameLike(String managerName) {
        return StringUtils.hasText(managerName) ? inbound.manager.name.containsIgnoreCase(managerName) : null;
    }

    private BooleanExpression productNameLike(String name) {
        return StringUtils.hasText(name) ? product.name.containsIgnoreCase(name) : null;
    }

    private BooleanExpression vendorIdsIn(List<Long> vendorIds) {
        return CollectionUtils.isEmpty(vendorIds) ? null : purchaseOrder.vendor.id.in(vendorIds);
    }
}
