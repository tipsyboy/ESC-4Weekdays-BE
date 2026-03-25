package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.product.es.dto.ProductSearchResponse;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    public List<ProductSearchResponse> searchProducts(ProductSearchRequest request) {
        if (!request.hasSearchCondition()) {
            return List.of();
        }

        return productSearchRepository.search(request).stream()
                .map(ProductSearchResponse::from)
                .toList();
    }
}
