package com.fourweekdays.fourweekdays.product.service;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import com.fourweekdays.fourweekdays.product.model.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.model.entity.ProductDocument;
import com.fourweekdays.fourweekdays.product.repository.ProductSearchRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.SearchHits;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProductEsService {

    private final ProductSearchRepository productSearchRepository;

    public Page<ProductReadDto> searchProducts(ProductSearchRequest request, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        SearchHits<ProductDocument> results = productSearchRepository.search(request, pageable);

        List<ProductReadDto> content = results.getSearchHits()
                .stream()
                .map(SearchHit::getContent)
                .map(doc -> ProductReadDto.builder()
                        .id(doc.getProductId())
                        .name(doc.getName())
                        .productCode(doc.getProductCode())
                        .unit(doc.getUnit())
                        .unitPrice(doc.getUnitPrice())
                        .description(doc.getDescription())
                        .status(doc.getStatus())
                        .vendor(null)
                        .vendorName(doc.getVendorName())
                        .createdAt(OffsetDateTime.parse(doc.getCreatedAt()).toLocalDateTime()) // TODO: 변환 로직 진짜 쓰레기다.
                        .updatedAt(OffsetDateTime.parse(doc.getUpdatedAt()).toLocalDateTime())
                        .build())
                .toList();

        long totalElements = results.getTotalHits();

        return new PageImpl<>(content, pageable, totalElements);
    }

}