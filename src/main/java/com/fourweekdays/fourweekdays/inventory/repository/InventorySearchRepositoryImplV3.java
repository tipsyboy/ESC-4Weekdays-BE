//package com.fourweekdays.fourweekdays.inventory.repository;
//
//import co.elastic.clients.elasticsearch._types.FieldValue;
//import co.elastic.clients.elasticsearch._types.SortOrder;
//import co.elastic.clients.elasticsearch._types.aggregations.Aggregate;
//import co.elastic.clients.elasticsearch._types.aggregations.CompositeAggregate;
//import co.elastic.clients.elasticsearch._types.aggregations.CompositeBucket;
//import co.elastic.clients.elasticsearch._types.query_dsl.BoolQuery;
//import co.elastic.clients.elasticsearch._types.query_dsl.Query;
//import co.elastic.clients.json.JsonData;
//import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
//import com.fourweekdays.fourweekdays.inventory.model.entity.InventoryDocument;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.data.domain.Pageable;
//import org.springframework.data.elasticsearch.client.elc.ElasticsearchAggregations;
//import org.springframework.data.elasticsearch.client.elc.NativeQuery;
//import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
//import org.springframework.data.elasticsearch.core.SearchHits;
//import org.springframework.stereotype.Repository;
//import org.springframework.util.StringUtils;
//
//import java.time.LocalDateTime;
//import java.time.LocalTime;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Map;
//
//@Slf4j
//@RequiredArgsConstructor
//@Repository
//public class InventorySearchRepositoryImplV3 implements InventorySearchRepository {
//
//    private final ElasticsearchOperations operations;
//
//    /**
//     * 1단계: Composite Aggregation으로 ProductId 조회 (페이징 지원)
//     */
//    @Override
//    public List<Long> searchProductIds(InventorySearchRequest searchRequest, Pageable pageable) {
//
//        // ES Query 빌드
//        Query esQuery = buildQuery(searchRequest);
//
//        // Composite Aggregation 설정
//        int from = (int) pageable.getOffset();
//        int size = pageable.getPageSize();
//
//        List<Long> allProductIds = new ArrayList<>();
//        Map<String, FieldValue> afterKey = null;
//        int fetchedCount = 0;
//
//        // offset + size만큼 데이터를 가져올 때까지 반복
//        while (fetchedCount < from + size) {
//            int batchSize = Math.min(10000, from + size - fetchedCount);
//
//            NativeQuery.NativeQueryBuilder queryBuilder = NativeQuery.builder()
//                    .withQuery(esQuery)
//                    .withMaxResults(0); // hits는 필요 없음
//
//            // Composite Aggregation 빌드
//            queryBuilder.withAggregation("product_ids", agg -> agg
//                    .composite(comp -> {
//                        comp.size(batchSize)
//                                .sources(src -> src
//                                        .terms(t -> t
//                                                .field("productId")
//                                                .name("productId")
//                                        )
//                                );
//                        if (afterKey != null) {
//                            comp.after(afterKey);
//                        }
//                        return comp;
//                    })
//            );
//
//            SearchHits<InventoryDocument> searchHits = operations.search(
//                    queryBuilder.build(),
//                    InventoryDocument.class
//            );
//
//            // Aggregation 결과 파싱
//            ElasticsearchAggregations aggregations = (ElasticsearchAggregations) searchHits.getAggregations();
//            if (aggregations == null) {
//                break;
//            }
//
//            Aggregate productIdsAgg = aggregations.aggregations().get("product_ids");
//            if (productIdsAgg == null) {
//                break;
//            }
//
//            CompositeAggregate compositeAgg = productIdsAgg.composite();
//            List<CompositeBucket> buckets = compositeAgg.buckets().array();
//
//            if (buckets.isEmpty()) {
//                break;
//            }
//
//            // ProductId 추출
//            List<Long> batchProductIds = buckets.stream()
//                    .map(bucket -> {
//                        FieldValue productIdField = bucket.key().get("productId");
//                        return productIdField.longValue();
//                    })
//                    .toList();
//
//            allProductIds.addAll(batchProductIds);
//            fetchedCount += batchProductIds.size();
//
//            // afterKey 가져오기
//            afterKey = compositeAgg.afterKey();
//
//            // 더 이상 결과가 없으면 종료
//            if (afterKey == null || batchProductIds.size() < batchSize) {
//                break;
//            }
//
//            // 충분히 가져왔으면 종료
//            if (fetchedCount >= from + size) {
//                break;
//            }
//        }
//
//        // 페이징 적용
//        int start = Math.min(from, allProductIds.size());
//        int end = Math.min(from + size, allProductIds.size());
//        List<Long> pagedProductIds = allProductIds.subList(start, end);
//
//        log.info("[V3] Total fetched products: {}, Paged: {}", fetchedCount, pagedProductIds.size());
//
//        return pagedProductIds;
//    }
//
//    /**
//     * 2단계: Total Count 조회 (Cardinality Aggregation 사용)
//     */
//    @Override
//    public long countDistinctProducts(InventorySearchRequest searchRequest) {
//
//        Query esQuery = buildQuery(searchRequest);
//
//        NativeQuery nativeQuery = NativeQuery.builder()
//                .withQuery(esQuery)
//                .withAggregation("distinct_product_count", agg -> agg
//                        .cardinality(c -> c
//                                .field("productId")
//                                .precisionThreshold(40000)
//                        )
//                )
//                .withMaxResults(0)
//                .build();
//
//        SearchHits<InventoryDocument> searchHits = operations.search(
//                nativeQuery,
//                InventoryDocument.class
//        );
//
//        ElasticsearchAggregations aggregations = (ElasticsearchAggregations) searchHits.getAggregations();
//        if (aggregations == null) {
//            return 0L;
//        }
//
//        Aggregate countAgg = aggregations.aggregations().get("distinct_product_count");
//        if (countAgg == null) {
//            return 0L;
//        }
//
//        long count = (long) countAgg.cardinality().value();
//        log.info("[V3] Distinct product count: {}", count);
//
//        return count;
//    }
//
//    /**
//     * 3단계: ProductId 목록으로 Inventory 조회
//     */
//    @Override
//    public SearchHits<InventoryDocument> searchByProductIds(
//            List<Long> productIds,
//            InventorySearchRequest searchRequest
//    ) {
//
//        Query esQuery = buildQueryWithProductIds(productIds, searchRequest);
//
//        NativeQuery nativeQuery = NativeQuery.builder()
//                .withQuery(esQuery)
//                .withSort(s -> s.field(f -> f.field("createdAt").order(SortOrder.Desc)))
//                .withMaxResults(10000)
//                .build();
//
//        SearchHits<InventoryDocument> results = operations.search(
//                nativeQuery,
//                InventoryDocument.class
//        );
//
//        log.info("[V3] Inventory 조회 결과: {}", results.getSearchHits().size());
//        return results;
//    }
//
//    @Override
//    public SearchHits<InventoryDocument> search(InventorySearchRequest searchRequest, Pageable pageable) {
//        // 필요시 구현
//        return null;
//    }
//
//    // =========================================================
//    //  쿼리 빌더
//    // =========================================================
//
//    /**
//     * 전체 조건 쿼리 빌드 (Product + Inventory)
//     */
//    private Query buildQuery(InventorySearchRequest request) {
//        return Query.of(q -> q.bool(b -> {
//            addProductConditions(b, request);
//            addInventoryConditions(b, request);
//            return b;
//        }));
//    }
//
//    /**
//     * ProductId 조건 포함 쿼리 빌드
//     */
//    private Query buildQueryWithProductIds(List<Long> productIds, InventorySearchRequest request) {
//        return Query.of(q -> q.bool(b -> {
//            // ProductId 필터
//            b.filter(f -> f.terms(t -> t
//                    .field("productId")
//                    .terms(terms -> terms.value(
//                            productIds.stream()
//                                    .map(FieldValue::of)
//                                    .toList()
//                    ))
//            ));
//
//            addInventoryConditions(b, request);
//            return b;
//        }));
//    }
//
//    /**
//     * Product 조건 추가
//     */
//    private void addProductConditions(BoolQuery.Builder builder, InventorySearchRequest request) {
//        // 상품명 (부분 검색 - nori analyzer)
//        if (hasText(request.productName())) {
//            builder.must(m -> m.match(match -> match
//                    .field("productName")
//                    .query(request.productName())
//            ));
//        }
//
//        // 상품코드 (부분 검색)
//        if (hasText(request.productCode())) {
//            builder.must(m -> m.wildcard(w -> w
//                    .field("productCode")
//                    .value("*" + request.productCode() + "*")
//            ));
//        }
//
//        // 상품 상태 (정확 매칭)
//        if (hasText(request.productStatus())) {
//            builder.filter(f -> f.term(t -> t
//                    .field("productStatus")
//                    .value(request.productStatus())
//            ));
//        }
//
//        // 공급사명 (부분 검색)
//        if (hasText(request.vendorName())) {
//            builder.must(m -> m.wildcard(w -> w
//                    .field("vendorName")
//                    .value("*" + request.vendorName() + "*")
//            ));
//        }
//
//        // 가격 범위
//        if (request.minPrice() != null || request.maxPrice() != null) {
//            builder.filter(f -> f.range(r -> {
//                r.field("unitPrice");
//                if (request.minPrice() != null) {
//                    r.gte(JsonData.of(request.minPrice()));
//                }
//                if (request.maxPrice() != null) {
//                    r.lte(JsonData.of(request.maxPrice()));
//                }
//                return r;
//            }));
//        }
//    }
//
//    /**
//     * Inventory 조건 추가
//     */
//    private void addInventoryConditions(BoolQuery.Builder builder, InventorySearchRequest request) {
//        // 수량 > 0 (필수)
//        builder.filter(f -> f.range(r -> r
//                .field("quantity")
//                .gt(JsonData.of(0))
//        ));
//
//        // 수량 범위
//        if (request.minQuantity() != null || request.maxQuantity() != null) {
//            builder.filter(f -> f.range(r -> {
//                r.field("quantity");
//                if (request.minQuantity() != null) {
//                    r.gte(JsonData.of(request.minQuantity()));
//                }
//                if (request.maxQuantity() != null) {
//                    r.lte(JsonData.of(request.maxQuantity()));
//                }
//                return r;
//            }));
//        }
//
//        // Lot 번호 (부분 검색)
//        if (hasText(request.lotNumber())) {
//            builder.must(m -> m.wildcard(w -> w
//                    .field("lotNumber")
//                    .value("*" + request.lotNumber() + "*")
//            ));
//        }
//
//        // 로케이션 코드 (정확 매칭)
//        if (hasText(request.locationCode())) {
//            builder.filter(f -> f.term(t -> t
//                    .field("locationCode")
//                    .value(request.locationCode())
//            ));
//        }
//
//        // 입고 코드 (부분 검색)
//        if (hasText(request.inboundCode())) {
//            builder.must(m -> m.wildcard(w -> w
//                    .field("inboundCode")
//                    .value("*" + request.inboundCode() + "*")
//            ));
//        }
//
//        // 입고일 범위
//        if (request.inboundDateFrom() != null || request.inboundDateTo() != null) {
//            builder.filter(f -> f.range(r -> {
//                r.field("inboundDate");
//                if (request.inboundDateFrom() != null) {
//                    r.gte(JsonData.of(atStartOfDay(request.inboundDateFrom()).toString()));
//                }
//                if (request.inboundDateTo() != null) {
//                    r.lte(JsonData.of(atEndOfDay(request.inboundDateTo()).toString()));
//                }
//                return r;
//            }));
//        }
//
//        // 생성일 범위
//        if (request.createdFrom() != null || request.createdTo() != null) {
//            builder.filter(f -> f.range(r -> {
//                r.field("createdAt");
//                if (request.createdFrom() != null) {
//                    r.gte(JsonData.of(atStartOfDay(request.createdFrom()).toString()));
//                }
//                if (request.createdTo() != null) {
//                    r.lte(JsonData.of(atEndOfDay(request.createdTo()).toString()));
//                }
//                return r;
//            }));
//        }
//    }
//
//    // =========================================================
//    //  유틸
//    // =========================================================
//
//    private boolean hasText(String value) {
//        return StringUtils.hasText(value);
//    }
//
//    private LocalDateTime atStartOfDay(java.time.LocalDate date) {
//        return date.atStartOfDay();
//    }
//
//    private LocalDateTime atEndOfDay(java.time.LocalDate date) {
//        return date.atTime(LocalTime.of(23, 59, 59, 999_999_000));
//    }
//}