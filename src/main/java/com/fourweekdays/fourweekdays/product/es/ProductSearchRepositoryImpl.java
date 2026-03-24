package com.fourweekdays.fourweekdays.product.es;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.elasticsearch.client.elc.NativeQuery;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHit;

import java.util.List;

import static co.elastic.clients.elasticsearch._types.query_dsl.QueryBuilders.match;

@RequiredArgsConstructor
public class ProductSearchRepositoryImpl implements ProductSearchRepositoryCustom {

    private final ElasticsearchOperations elasticsearchOperations;

    @Override
    public List<ProductDocument> searchByName(String keyword) {
        NativeQuery query = NativeQuery.builder()
                .withQuery(match(m -> m.field("name").query(keyword)))
                .withPageable(PageRequest.of(0, 100))
                .build();

        return elasticsearchOperations.search(query, ProductDocument.class)
                .stream()
                .map(SearchHit::getContent)
                .toList();
    }
}
