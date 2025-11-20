package com.fourweekdays.fourweekdays.inventory.repository;

import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
import com.fourweekdays.fourweekdays.inventory.model.dto.response.ProductInventoryResponse;
import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.JPAExpressions;
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

@Slf4j
@RequiredArgsConstructor
public class InventoryRepositoryCustomImpl implements InventoryRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<ProductInventoryResponse> searchInventoryByProduct(Pageable pageable, InventorySearchRequest request) {
        // 1. 조회 대상 Product ID 페이징 조회
        List<Long> productIds = findProductIdsBySearchCondition(pageable, request);

        if (productIds.isEmpty()) {
            return new PageImpl<>(List.of(), pageable, 0L);
        }

        // 2. 전체 Product 개수 조회
        Long total = countProductsBySearchCondition(request);

        // 3. Inventory + Product + Location + Inbound fetchJoin 조회
        List<Inventory> inventories = findInventoriesByProductIds(productIds, request);

        // 4. Product 기준 그룹핑
        Map<Long, List<Inventory>> inventoryMap = groupInventoriesByProductId(inventories);

        // 5. Product ID 순서를 유지하면서 응답 생성
        List<ProductInventoryResponse> results = buildProductInventoryResponses(productIds, inventoryMap);

        return new PageImpl<>(results, pageable, total != null ? total : 0L);
    }

    /**
     * product 기준 페이징 ID 조회 (EXISTS 사용, DISTINCT 제거)
     */
    private List<Long> findProductIdsBySearchCondition(Pageable pageable, InventorySearchRequest request) {
        return queryFactory
                .select(product.id)
                .from(product)
                .where(
                        productCodeEq(request.productCode()),
                        productNameLike(request.productName()),
                        existsInventoryBySearchCondition(request)
                )
                .orderBy(product.id.asc())
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetch();
    }

    /**
     * 조건에 맞는 product 총 개수
     */
    private Long countProductsBySearchCondition(InventorySearchRequest request) {
        return queryFactory
                .select(product.id.count())
                .from(product)
                .where(
                        productCodeEq(request.productCode()),
                        productNameLike(request.productName()),
                        existsInventoryBySearchCondition(request)
                )
                .fetchOne();
    }

    /**
     * 선택된 productIds에 대한 inventory + 연관 엔티티 fetchJoin
     */
    private List<Inventory> findInventoriesByProductIds(List<Long> productIds, InventorySearchRequest request) {
        return queryFactory
                .selectFrom(inventory)
                .join(inventory.product, product).fetchJoin()
                .join(inventory.location, location).fetchJoin()
                .leftJoin(inventory.inbound, inbound).fetchJoin()
                .where(
                        inventory.product.id.in(productIds),
                        inventory.quantity.gt(0),
                        locationCodeEq(request.locationCode()),
                        inboundCodeEq(request.inboundCode()),
                        inboundAtBetween(request.createdFrom(), request.createdTo())
                )
                .orderBy(inventory.createdAt.desc())
                .fetch();
    }

    /**
     * productId 기준으로 inventory 리스트 그룹핑
     */
    private Map<Long, List<Inventory>> groupInventoriesByProductId(List<Inventory> inventories) {
        return inventories.stream()
                .collect(Collectors.groupingBy(inv -> inv.getProduct().getId()));
    }

    /**
     * productIds 순서를 보존하면서 응답 DTO 생성
     */
    private List<ProductInventoryResponse> buildProductInventoryResponses(
            List<Long> productIds,
            Map<Long, List<Inventory>> inventoryMap
    ) {
        return productIds.stream()
                .map(productId -> {
                    List<Inventory> invList = inventoryMap.getOrDefault(productId, List.of());
                    Product p = invList.isEmpty() ? null : invList.get(0).getProduct();
                    return p != null ? ProductInventoryResponse.from(p, invList) : null;
                })
                .filter(Objects::nonNull)
                .toList();
    }

    /**
     * inventory 존재 여부를 이용한 EXISTS 서브쿼리
     * (DISTINCT 없이 product 기준 필터링을 하기 위한 핵심)
     */
    private BooleanExpression existsInventoryBySearchCondition(InventorySearchRequest request) {
        return JPAExpressions
                .selectOne()
                .from(inventory)
                .leftJoin(inventory.location, location)
                .leftJoin(inventory.inbound, inbound)
                .where(
                        inventory.product.eq(product),
                        inventory.quantity.gt(0),
                        locationCodeEq(request.locationCode()),
                        inboundCodeEq(request.inboundCode()),
                        inboundAtBetween(request.createdFrom(), request.createdTo())
                )
                .exists();
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


    @Override
    public Page<Inventory> searchInventory(Pageable pageable, InventorySearchRequest request) {
        return null;
//        List<Inventory> inventories = queryFactory
//                .selectFrom(inventory)
//                .leftJoin(inventory.product, product).fetchJoin()
//                .leftJoin(inventory.location, location).fetchJoin()
//                .leftJoin(inventory.inbound, inbound).fetchJoin()
//                .leftJoin(product.vendor, vendor).fetchJoin()
//                .where(
//                        inboundCodeEq(request.inboundCode()),
//                        managerNameLike(request.inboundManagerName()),
//                        productCodeEq(request.productCode()),
//                        productNameLike(request.productName()),
//                        locationCodeEq(request.locationCode()),
//                        inboundAtBetween(request.createdFrom(), request.createdTo())
//                )
//                .offset(pageable.getOffset())
//                .limit(pageable.getPageSize())
//                .orderBy(inventory.createdAt.desc())
//                .fetch();
//
//        Long total = queryFactory
//                .select(inventory.count())
//                .from(inventory)
//                .leftJoin(inventory.product, product)
//                .leftJoin(inventory.location, location)
//                .leftJoin(inventory.inbound, inbound)
//                .where(
//                        inboundCodeEq(request.inboundCode()),
//                        managerNameLike(request.inboundManagerName()),
//                        productCodeEq(request.productCode()),
//                        productNameLike(request.productName()),
//                        locationCodeEq(request.locationCode()),
//                        inboundAtBetween(request.createdFrom(), request.createdTo())
//                )
//                .fetchOne();
//
//        return new PageImpl<>(inventories, pageable, total != null ? total : 0L);
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
