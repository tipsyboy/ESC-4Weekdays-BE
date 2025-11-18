package com.fourweekdays.fourweekdays.inventory.repository;

import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
import com.fourweekdays.fourweekdays.inventory.model.entity.InventoryDocument;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.SearchHits;

import java.util.List;

public interface InventorySearchRepository {

    List<Long> searchProductIds(InventorySearchRequest searchRequest, Pageable pageable);

    long countDistinctProducts(InventorySearchRequest searchRequest);

    SearchHits<InventoryDocument> searchByProductIds(List<Long> productIds, InventorySearchRequest searchRequest);

    SearchHits<InventoryDocument> search(InventorySearchRequest searchRequest, Pageable pageable);
}

