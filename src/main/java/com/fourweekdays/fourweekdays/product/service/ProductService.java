package com.fourweekdays.fourweekdays.product.service;

import com.fourweekdays.fourweekdays.product.model.Product;
import com.fourweekdays.fourweekdays.product.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.dto.request.ProductCreateDto;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    // 상품 등록
    public Long register(ProductCreateDto dto) {
        Product result = productRepository.save(dto.toEntity());
        return result.getId();
    }

    // 상품 전체 조회
    public List<ProductReadDto> getProductList() {
        return productRepository.findAll().stream()
                .map(Product::toDto)
                .collect(Collectors.toList());
    }

    // 상품 상세 조회
    public ProductReadDto getProductDetails(Long id) {
        return productRepository.findById(id)
                .map(Product::toDto)
                .orElse(null); // 요청에 따라 예외 처리 대신 null 반환
    }
}

