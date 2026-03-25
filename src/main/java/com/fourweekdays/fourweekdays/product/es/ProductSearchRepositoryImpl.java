package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.elasticsearch.client.elc.NativeQuery;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.util.StringUtils;

import java.util.List;

import static co.elastic.clients.elasticsearch._types.query_dsl.QueryBuilders.bool;
import static co.elastic.clients.elasticsearch._types.query_dsl.QueryBuilders.match;
import static co.elastic.clients.elasticsearch._types.query_dsl.QueryBuilders.term;

@RequiredArgsConstructor
public class ProductSearchRepositoryImpl implements ProductSearchRepositoryCustom {

    private final ElasticsearchOperations elasticsearchOperations;

    @Override
    public List<ProductDocument> search(ProductSearchRequest request) {
        NativeQuery query = NativeQuery.builder()
                .withQuery(bool(b -> {
                    if (StringUtils.hasText(request.productName())) {
                        b.must(match(m -> m.field("name").query(request.productName())));
                    }
                    if (StringUtils.hasText(request.productCode())) {
                        b.filter(term(t -> t.field("product_code").value(request.productCode())));
                    }
                    if (request.status() != null) {
                        b.filter(term(t -> t.field("status").value(request.status().name())));
                    }
                    if (StringUtils.hasText(request.vendorName())) {
                        b.must(match(m -> m.field("vendor_name").query(request.vendorName())));
                    }
                    if (request.minPrice() != null || request.maxPrice() != null) {
                        b.filter(q -> q.range(r -> r.number(n -> {
                            n.field("unit_price");
                            if (request.minPrice() != null) {
                                n.gte(request.minPrice().doubleValue());
                            }
                            if (request.maxPrice() != null) {
                                n.lte(request.maxPrice().doubleValue());
                            }
                            return n;
                        })));
                    }
                    return b;
                }))
                .withPageable(PageRequest.of(0, 100)) // TODO: 이후 pageable을 받아서 처리
                .build();

        return elasticsearchOperations.search(query, ProductDocument.class)
                .stream()
                .map(SearchHit::getContent)
                .toList();
    }
}
