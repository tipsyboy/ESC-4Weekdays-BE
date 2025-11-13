package com.fourweekdays.fourweekdays.search;

import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;
import java.util.Optional;

public interface ProductDocumentRepository extends ElasticsearchRepository<ProductDocument, String> {

    // 상품명으로 검색
    List<ProductDocument> findByNameContaining(String name);

    // 상품코드로 검색
    Optional<ProductDocument> findByProductCode(String productCode);

    // 공급업체로 검색
    List<ProductDocument> findByVendorId(Long vendorId);
}