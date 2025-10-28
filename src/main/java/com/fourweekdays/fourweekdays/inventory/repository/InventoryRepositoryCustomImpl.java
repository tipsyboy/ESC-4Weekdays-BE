package com.fourweekdays.fourweekdays.inventory.repository;

import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.util.List;

import static com.fourweekdays.fourweekdays.inbound.model.entity.QInbound.inbound;
import static com.fourweekdays.fourweekdays.inventory.model.entity.QInventory.inventory;
import static com.fourweekdays.fourweekdays.location.model.entity.QLocation.location;
import static com.fourweekdays.fourweekdays.product.model.entity.QProduct.product;

@RequiredArgsConstructor
public class InventoryRepositoryCustomImpl implements InventoryRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<Inventory> searchInventory(Pageable pageable, InventorySearchRequest request) {
        List<Inventory> inventories = queryFactory
                .selectFrom(inventory)
                .leftJoin(inventory.product, product).fetchJoin()
                .leftJoin(inventory.location, location).fetchJoin()
                .leftJoin(inventory.inbound, inbound).fetchJoin()
                .where(
                        inboundCodeEq(request.inboundCode()),
                        managerNameLike(request.inboundManagerName()),
                        productCodeEq(request.productCode()),
                        productNameLike(request.productName()),
                        locationCodeEq(request.locationCode()),
                        inboundAtBetween(request.createdFrom(), request.createdTo())
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(inventory.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .select(inventory.count())
                .from(inventory)
                .leftJoin(inventory.product, product)
                .leftJoin(inventory.location, location)
                .leftJoin(inventory.inbound, inbound)
                .where(
                        inboundCodeEq(request.inboundCode()),
                        managerNameLike(request.inboundManagerName()),
                        productCodeEq(request.productCode()),
                        productNameLike(request.productName()),
                        locationCodeEq(request.locationCode()),
                        inboundAtBetween(request.createdFrom(), request.createdTo())
                )
                .fetchOne();

        return new PageImpl<>(inventories, pageable, total != null ? total : 0L);
    }

    private BooleanExpression productCodeEq(String productCode) {
        return StringUtils.hasText(productCode) ? product.productCode.eq(productCode) : null;
    }

    private BooleanExpression productNameLike(String productName) {
        return StringUtils.hasText(productName) ? product.name.contains(productName) : null;
    }

    private BooleanExpression locationCodeEq(String locationCode) {
        return StringUtils.hasText(locationCode) ? location.locationCode.eq(locationCode) : null;
    }

    private BooleanExpression inboundCodeEq(String inboundCode) {
        return StringUtils.hasText(inboundCode) ? inbound.inboundCode.eq(inboundCode) : null;
    }

    private BooleanExpression managerNameLike(String name) {
        return StringUtils.hasText(name) ? inbound.managerName.contains(name) : null;
    }

    private BooleanExpression inboundAtBetween(LocalDate from, LocalDate to) {
        if (from != null && to != null) {
            return inventory.createdAt.between(
                    from.atStartOfDay(),
                    to.atTime(23, 59, 59)
            );
        }

        if (from != null) {
            return inventory.createdAt.goe(from.atStartOfDay());
        }

        if (to != null) {
            return inventory.createdAt.loe(to.atTime(23, 59, 59));
        }

        return null;
    }
}
