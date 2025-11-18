package com.fourweekdays.fourweekdays.inventory.repository;

import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
import com.fourweekdays.fourweekdays.inventory.model.entity.InventoryDocument;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.data.elasticsearch.core.query.Criteria;
import org.springframework.data.elasticsearch.core.query.CriteriaQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.fourweekdays.fourweekdays.inventory.model.entity.QInventory.inventory;
import static com.fourweekdays.fourweekdays.location.model.entity.QLocation.location;
import static com.fourweekdays.fourweekdays.inbound.model.entity.QInbound.inbound;
import static com.fourweekdays.fourweekdays.product.model.entity.QProduct.product;

@Slf4j
@RequiredArgsConstructor
//@Repository
public class InventorySearchRepositoryImplV1 implements InventorySearchRepository {

    private final ElasticsearchOperations operations;
    private final JPAQueryFactory queryFactory;

    /**
     * 1단계: Product ID 조회 (QueryDSL 사용, 페이징)
     */
    @Override
    public List<Long> searchProductIds(InventorySearchRequest searchRequest, Pageable pageable) {
        List<Long> productIds = queryFactory
                .select(product.id).distinct()
                .from(product)
                .innerJoin(inventory).on(inventory.product.eq(product))
                .leftJoin(inventory.location, location)
                .leftJoin(inventory.inbound, inbound)
                .where(
                        productCodeEq(searchRequest.productCode()),
                        productNameLike(searchRequest.productName()),
                        inventory.quantity.gt(0),
                        locationCodeEq(searchRequest.locationCode()),
                        inboundCodeEq(searchRequest.inboundCode()),
                        createdAtBetween(searchRequest.createdFrom(), searchRequest.createdTo())
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(product.productCode.asc())
                .fetch();

        log.info("검색된 Product 개수: {}", productIds.size());
        return productIds;
    }

    /**
     * 2단계: Total Product count 조회 (QueryDSL)
     */
    @Override
    public long countDistinctProducts(InventorySearchRequest searchRequest) {
        Long total = queryFactory
                .select(product.id.countDistinct())
                .from(product)
                .innerJoin(inventory).on(inventory.product.eq(product))
                .leftJoin(inventory.location, location)
                .leftJoin(inventory.inbound, inbound)
                .where(
                        productCodeEq(searchRequest.productCode()),
                        productNameLike(searchRequest.productName()),
                        inventory.quantity.gt(0),
                        locationCodeEq(searchRequest.locationCode()),
                        inboundCodeEq(searchRequest.inboundCode()),
                        createdAtBetween(searchRequest.createdFrom(), searchRequest.createdTo())
                )
                .fetchOne();

        log.info("전체 Product 개수: {}", total);
        return total != null ? total : 0L;
    }

    /**
     * 3단계: Product ID 목록으로 Inventory 조회 (ES)
     */
    @Override
    public SearchHits<InventoryDocument> searchByProductIds(List<Long> productIds, InventorySearchRequest searchRequest) {

        Criteria criteria = buildCriteria(searchRequest);
        criteria = criteria.and(new Criteria("productId").in(productIds));

        // createdAt 기준 내림차순 정렬
        Pageable pageable = PageRequest.of(0, 10000, Sort.by(Sort.Order.desc("created_at")));
        CriteriaQuery query = new CriteriaQuery(criteria, pageable);

        SearchHits<InventoryDocument> results = operations.search(query, InventoryDocument.class);
        log.info("조회된 Inventory 개수: {}", results.getSearchHits().size());

        return results;
    }

    /**
     * 일반 검색 (필요시 사용)
     */
    @Override
    public SearchHits<InventoryDocument> search(InventorySearchRequest searchRequest, Pageable pageable) {
        Criteria criteria = buildCriteria(searchRequest);

        Pageable sortedPageable = PageRequest.of(
                pageable.getPageNumber(),
                pageable.getPageSize(),
                Sort.by(Sort.Order.desc("inventoryId"))
        );

        CriteriaQuery query = new CriteriaQuery(criteria, sortedPageable);
        SearchHits<InventoryDocument> results = operations.search(query, InventoryDocument.class);

        log.info("ES 재고 조회 결과: {} / {}", results.getSearchHits().size(), results.getTotalHits());

        return results;
    }

    // ===== QueryDSL Where 조건 =====

    private com.querydsl.core.types.dsl.BooleanExpression productCodeEq(String productCode) {
        return productCode != null ? product.productCode.eq(productCode) : null;
    }

    private com.querydsl.core.types.dsl.BooleanExpression productNameLike(String productName) {
        return productName != null ? product.name.contains(productName) : null;
    }

    private com.querydsl.core.types.dsl.BooleanExpression locationCodeEq(String locationCode) {
        return locationCode != null ? location.locationCode.eq(locationCode) : null;
    }

    private com.querydsl.core.types.dsl.BooleanExpression inboundCodeEq(String inboundCode) {
        return inboundCode != null ? inbound.inboundCode.eq(inboundCode) : null;
    }

    private com.querydsl.core.types.dsl.BooleanExpression createdAtBetween(
            java.time.LocalDate from,
            java.time.LocalDate to) {
        if (from != null && to != null) {
            return inbound.createdAt.between(
                    from.atStartOfDay(),
                    to.atTime(23, 59, 59)
            );
        } else if (from != null) {
            return inbound.createdAt.goe(from.atStartOfDay());
        } else if (to != null) {
            return inbound.createdAt.loe(to.atTime(23, 59, 59));
        }
        return null;
    }

    // ===== ES Criteria 빌더 =====

    /**
     * 검색 조건 공통 빌더
     */
    private Criteria buildCriteria(InventorySearchRequest searchRequest) {
        Criteria criteria = new Criteria();

        if (searchRequest.productName() != null && !searchRequest.productName().isEmpty()) {
            criteria = criteria.and(new Criteria("productName").matches(searchRequest.productName()));
        }

        if (searchRequest.productCode() != null && !searchRequest.productCode().isEmpty()) {
            criteria = criteria.and(new Criteria("productCode").is(searchRequest.productCode()));
        }

        if (searchRequest.productStatus() != null) {
            criteria = criteria.and(new Criteria("productStatus").is(searchRequest.productStatus()));
        }

        if (searchRequest.vendorName() != null && !searchRequest.vendorName().isEmpty()) {
            criteria = criteria.and(new Criteria("vendorName").contains(searchRequest.vendorName()));
        }

        if (searchRequest.minQuantity() != null && searchRequest.maxQuantity() != null) {
            criteria = criteria.and(new Criteria("quantity").between(searchRequest.minQuantity(), searchRequest.maxQuantity()));
        } else if (searchRequest.minQuantity() != null) {
            criteria = criteria.and(new Criteria("quantity").greaterThanEqual(searchRequest.minQuantity()));
        } else if (searchRequest.maxQuantity() != null) {
            criteria = criteria.and(new Criteria("quantity").lessThanEqual(searchRequest.maxQuantity()));
        }

        if (searchRequest.minPrice() != null && searchRequest.maxPrice() != null) {
            criteria = criteria.and(new Criteria("unitPrice").between(searchRequest.minPrice(), searchRequest.maxPrice()));
        } else if (searchRequest.minPrice() != null) {
            criteria = criteria.and(new Criteria("unitPrice").greaterThanEqual(searchRequest.minPrice()));
        } else if (searchRequest.maxPrice() != null) {
            criteria = criteria.and(new Criteria("unitPrice").lessThanEqual(searchRequest.maxPrice()));
        }

        if (searchRequest.lotNumber() != null && !searchRequest.lotNumber().isEmpty()) {
            criteria = criteria.and(new Criteria("lotNumber").is(searchRequest.lotNumber()));
        }

        if (searchRequest.locationCode() != null && !searchRequest.locationCode().isEmpty()) {
            criteria = criteria.and(new Criteria("locationCode").is(searchRequest.locationCode()));
        }

        if (searchRequest.inboundCode() != null && !searchRequest.inboundCode().isEmpty()) {
            criteria = criteria.and(new Criteria("inboundCode").is(searchRequest.inboundCode()));
        }

        if (searchRequest.inboundDateFrom() != null && searchRequest.inboundDateTo() != null) {
            criteria = criteria.and(new Criteria("inboundDate").between(
                    searchRequest.inboundDateFrom(),
                    searchRequest.inboundDateTo()
            ));
        } else if (searchRequest.inboundDateFrom() != null) {
            criteria = criteria.and(new Criteria("inboundDate").greaterThanEqual(
                    searchRequest.inboundDateFrom()
            ));
        } else if (searchRequest.inboundDateTo() != null) {
            criteria = criteria.and(new Criteria("inboundDate").lessThanEqual(
                    searchRequest.inboundDateTo()
            ));
        }

        if (searchRequest.createdFrom() != null && searchRequest.createdTo() != null) {
            criteria = criteria.and(new Criteria("created_at").between(
                    searchRequest.createdFrom().atStartOfDay(),
                    searchRequest.createdTo().atTime(23, 59, 59)
            ));
        } else if (searchRequest.createdFrom() != null) {
            criteria = criteria.and(new Criteria("created_at").greaterThanEqual(
                    searchRequest.createdFrom().atStartOfDay()
            ));
        } else if (searchRequest.createdTo() != null) {
            criteria = criteria.and(new Criteria("created_at").lessThanEqual(
                    searchRequest.createdTo().atTime(23, 59, 59)
            ));
        }

        // 수량 > 0 조건 추가
        criteria = criteria.and(new Criteria("quantity").greaterThan(0L));

        return criteria;
    }
}