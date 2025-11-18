package com.fourweekdays.fourweekdays.inventory.service;


import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
import com.fourweekdays.fourweekdays.inventory.model.dto.response.ProductInventoryResponse;
import com.fourweekdays.fourweekdays.inventory.model.entity.InventoryDocument;
import com.fourweekdays.fourweekdays.inventory.repository.InventorySearchRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@Service
public class InventorySearchService {

    private final InventorySearchRepository inventorySearchRepository;

    public Page<ProductInventoryResponse> searchInventoryByProduct(InventorySearchRequest searchRequest, int page, int size) {

        Pageable pageable = PageRequest.of(page, size);

        // 1. Product ID 조회 (페이징)
        List<Long> productIds = inventorySearchRepository.searchProductIds(searchRequest, pageable);

        if (productIds.isEmpty()) {
            return new PageImpl<>(List.of(), pageable, 0L);
        }

        // 2. Total Count (Product 개수)
        long total = inventorySearchRepository.countDistinctProducts(searchRequest);

        // 3. Inventory 조회
        SearchHits<InventoryDocument> inventoryHits
                = inventorySearchRepository.searchByProductIds(productIds, searchRequest);

        List<InventoryDocument> inventories = inventoryHits.getSearchHits().stream()
                .map(SearchHit::getContent)
                .toList();

        // 4. 그룹핑
        Map<Long, List<InventoryDocument>> inventoryMap = inventories.stream()
                .collect(Collectors.groupingBy(InventoryDocument::getProductId));

        // 5. Product 순서대로 결과 생성 (productIds 순서 유지)
        List<ProductInventoryResponse> results = productIds.stream()
                .map(productId -> {
                    List<InventoryDocument> invList = inventoryMap.getOrDefault(productId, List.of());
                    return ProductInventoryResponse.from(invList);
                })
                .filter(Objects::nonNull)
                .toList();

        return new PageImpl<>(results, pageable, total);
    }
}






