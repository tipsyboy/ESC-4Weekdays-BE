package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import co.elastic.clients.elasticsearch._types.query_dsl.BoolQuery;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.elasticsearch.client.elc.NativeQuery;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.util.StringUtils;

import java.util.List;

import static co.elastic.clients.elasticsearch._types.query_dsl.QueryBuilders.bool;
import static co.elastic.clients.elasticsearch._types.query_dsl.QueryBuilders.match;
import static co.elastic.clients.elasticsearch._types.query_dsl.QueryBuilders.term;

@RequiredArgsConstructor
public class ProductSearchRepositoryImpl implements ProductSearchRepositoryCustom {

    private final ElasticsearchOperations elasticsearchOperations;

    @Override
    public List<ProductDocument> search(ProductSearchRequest request, int page, int size) {
        return searchHits(request, page, size).stream()
                .map(SearchHit::getContent)
                .toList();
    }

    @Override
    public SearchHits<ProductDocument> searchHits(ProductSearchRequest request, int page, int size) {
        NativeQuery query = NativeQuery.builder()
                .withQuery(bool(b -> {
                    productNameMatch(b, request);
                    productCodeTerm(b, request);
                    statusTerm(b, request);
                    vendorNameMatch(b, request);
                    unitPriceRange(b, request);
                    return b;
                }))
                .withPageable(PageRequest.of(page, size))
                .withTrackTotalHits(true)
                .build();

        return elasticsearchOperations.search(query, ProductDocument.class);
    }

    private void productNameMatch(BoolQuery.Builder builder, ProductSearchRequest request) {
        if (!StringUtils.hasText(request.productName())) {
            return;
        }
        builder.must(match(m -> m.field("name").query(request.productName())));
    }

    private void productCodeTerm(BoolQuery.Builder builder, ProductSearchRequest request) {
        if (!StringUtils.hasText(request.productCode())) {
            return;
        }
        builder.filter(term(t -> t.field("product_code").value(request.productCode())));
    }

    private void statusTerm(BoolQuery.Builder builder, ProductSearchRequest request) {
        if (request.status() == null) {
            return;
        }
        builder.filter(term(t -> t.field("status").value(request.status().name())));
    }

    private void vendorNameMatch(BoolQuery.Builder builder, ProductSearchRequest request) {
        if (!StringUtils.hasText(request.vendorName())) {
            return;
        }
        builder.must(match(m -> m.field("vendor_name").query(request.vendorName())));
    }

    private void unitPriceRange(BoolQuery.Builder builder, ProductSearchRequest request) {
        if (request.minPrice() == null && request.maxPrice() == null) {
            return;
        }
        builder.filter(q -> q.range(r -> r.number(n -> {
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
}
