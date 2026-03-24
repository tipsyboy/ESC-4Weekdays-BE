package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.product.es.dto.ProductSearchResponse;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProductSearchService {

    private final ProductRepository productRepository;
    private final ProductSearchRepository productSearchRepository;

    @Transactional
    public int reindexProducts() {
        List<Product> products = productRepository.findAllProductsForIndexing();
        List<ProductDocument> documents = products.stream()
                .map(ProductDocument::from)
                .toList();

        productSearchRepository.saveAll(documents);
        log.info("Product reindex completed. count={}", documents.size());

        return documents.size();
    }

    public List<ProductSearchResponse> searchProductsByName(String keyword) {
        // 검색어가 없으면 전체 조회로 확장하지 않고 빈 결과만 반환한다.
        if (!StringUtils.hasText(keyword)) {
            return List.of();
        }

        return productSearchRepository.searchByName(keyword).stream()
                .map(ProductSearchResponse::from)
                .toList();
    }
}
