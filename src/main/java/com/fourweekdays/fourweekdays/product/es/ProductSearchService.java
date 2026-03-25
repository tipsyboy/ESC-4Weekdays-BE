package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.product.es.dto.ProductSearchResponse;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
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

    public List<ProductSearchResponse> searchProducts(ProductSearchRequest request) {
        // 검색 조건이 없으면 전체 조회로 확장하지 않고 빈 결과만 반환한다.
        // TODO: dto로 빈 값 검색 판단 이동
        if (!StringUtils.hasText(request.productName())
                && !StringUtils.hasText(request.productCode())
                && request.status() == null
                && !StringUtils.hasText(request.vendorName())
                && request.minPrice() == null
                && request.maxPrice() == null) {
            return List.of();
        }

        return productSearchRepository.search(request).stream()
                .map(ProductSearchResponse::from)
                .toList();
    }
}
