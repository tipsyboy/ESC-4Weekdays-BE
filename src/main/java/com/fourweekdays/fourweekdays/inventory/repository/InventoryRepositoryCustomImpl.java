package com.fourweekdays.fourweekdays.inventory.repository;

import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
import com.fourweekdays.fourweekdays.inventory.model.dto.response.ProductInventoryResponse;
import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import static com.fourweekdays.fourweekdays.inbound.model.entity.QInbound.inbound;
import static com.fourweekdays.fourweekdays.inventory.model.entity.QInventory.inventory;
import static com.fourweekdays.fourweekdays.location.model.entity.QLocation.location;
import static com.fourweekdays.fourweekdays.product.model.entity.QProduct.product;
import static com.fourweekdays.fourweekdays.vendor.model.entity.QVendor.vendor;

@Slf4j
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
                .leftJoin(product.vendor, vendor).fetchJoin()
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

    @Override
    public Page<ProductInventoryResponse> searchInventoryByProduct(Pageable pageable, InventorySearchRequest request) {
        // 1. Product ID 조회 (페이징)
        List<Long> productIds = queryFactory
                .select(product.id).distinct()
                .from(product)
                .innerJoin(inventory).on(inventory.product.eq(product))
                .leftJoin(inventory.location, location)
                .leftJoin(inventory.inbound, inbound)
                .where(
                        productCodeEq(request.productCode()),
                        productNameLike(request.productName()),
                        inventory.quantity.gt(0),
                        locationCodeEq(request.locationCode()),
                        inboundCodeEq(request.inboundCode()),
                        inboundAtBetween(request.createdFrom(), request.createdTo())
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(product.productCode.asc())
                .fetch();

        // 2. Total Count (Product 개수)
        Long total = queryFactory
                .select(product.id.countDistinct())
                .from(product)
                .innerJoin(inventory).on(inventory.product.eq(product))
                .leftJoin(inventory.location, location)
                .leftJoin(inventory.inbound, inbound)
                .where(
                        productCodeEq(request.productCode()),
                        productNameLike(request.productName()),
                        inventory.quantity.gt(0),
                        locationCodeEq(request.locationCode()),
                        inboundCodeEq(request.inboundCode()),
                        inboundAtBetween(request.createdFrom(), request.createdTo())
                )
                .fetchOne();

        if (productIds.isEmpty()) {
            return new PageImpl<>(List.of(), pageable, 0L);
        }

        // 3. Inventory 조회 (Product도 fetchJoin으로 함께 조회)
        List<Inventory> inventories = queryFactory
                .selectFrom(inventory)
                .join(inventory.product, product).fetchJoin()
                .join(inventory.location, location).fetchJoin()
                .leftJoin(inventory.inbound, inbound).fetchJoin()
                .where(
                        product.id.in(productIds),
                        inventory.quantity.gt(0),
                        locationCodeEq(request.locationCode()),
                        inboundCodeEq(request.inboundCode()),
                        inboundAtBetween(request.createdFrom(), request.createdTo())
                )
                .orderBy(inventory.createdAt.desc())
                .fetch();

        // 4. 그룹핑
        Map<Long, List<Inventory>> inventoryMap = inventories.stream()
                .collect(Collectors.groupingBy(inv -> inv.getProduct().getId()));

        // 5. Product 순서대로 결과 생성 (productIds 순서 유지)
        List<ProductInventoryResponse> results = productIds.stream()
                .map(productId -> {
                    List<Inventory> invList = inventoryMap.getOrDefault(productId, List.of());
                    // invList의 첫 번째 요소에서 Product를 가져옴 (fetchJoin으로 이미 로드됨)
                    Product p = invList.isEmpty() ? null : invList.get(0).getProduct();
                    return p != null ? ProductInventoryResponse.from(p, invList) : null;
                })
                .filter(Objects::nonNull)
                .toList();

        return new PageImpl<>(results, pageable, total != null ? total : 0L);
    }


    @Override
    public Optional<ProductInventoryResponse> findDetailByProductCode(String productCode) {
        Product findProduct = queryFactory
                .selectFrom(product)
                .leftJoin(product.vendor).fetchJoin()
                .where(product.productCode.eq(productCode))
                .fetchOne();


        if (findProduct == null) {
            return Optional.empty();
        }

        List<Inventory> inventories = queryFactory
                .selectFrom(inventory)
                .leftJoin(inventory.location).fetchJoin()
                .leftJoin(inventory.inbound).fetchJoin()
                .where(
                        productCodeEq(productCode)
                )
                .fetch();

        // 3. DTO 변환 (정적 팩토리 메서드 활용)
        return Optional.of(ProductInventoryResponse.from(findProduct, inventories));
    }


    //===== 조건 =====//
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
        return StringUtils.hasText(name) ? inbound.manager.name.contains(name) : null;
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
