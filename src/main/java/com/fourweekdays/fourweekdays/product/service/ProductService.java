package com.fourweekdays.fourweekdays.product.service;

import com.fourweekdays.fourweekdays.category.model.Category;
import com.fourweekdays.fourweekdays.category.repository.CategoryRepository;
import com.fourweekdays.fourweekdays.product.dto.request.ProductCreateDto;
import com.fourweekdays.fourweekdays.product.dto.request.ProductStatusUpdateDto;
import com.fourweekdays.fourweekdays.product.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.model.*;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.product.repository.ProductStatusHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ProductStatusHistoryRepository historyRepository;

    // 상품 등록
    @Transactional
    public Long register(ProductCreateDto dto) {
        Category category = null;

        // categoryId 존재 시 → 기존 카테고리 연결
        if (dto.getCategoryId() != null) {
            category = categoryRepository.findById(dto.getCategoryId())
                    .orElseThrow(() -> new RuntimeException("해당 카테고리를 찾을 수 없습니다."));
        }

        // categoryId 없고 이름 정보(categoryLarge~Small)만 있을 경우 → 카테고리 생성 or 조회
        else if (dto.getCategoryLarge() != null && dto.getCategoryMedium() != null && dto.getCategorySmall() != null) {
            category = findOrCreateCategory(dto.getCategoryLarge(), dto.getCategoryMedium(), dto.getCategorySmall());
        }

        // 상품 생성 및 저장
        Product product = dto.toEntity(category);
        product.updateStatus(ProductStatus.RECEIVED); // 기본 상태: 입고(RECEIVED)
        Product saved = productRepository.save(product);

        // 최초 상태 이력 기록
        ProductStatusHistory history = ProductStatusHistory.builder()
                .product(saved)
                .oldStatus(null)
                .newStatus(ProductStatus.RECEIVED)
                .changedBy("SYSTEM") // 작업자 ID or 이름 등 정보 필요
                .build();

        historyRepository.save(history);

        return saved.getId();
    }


    // 상태 변경(변경시 ProductStatusHistory에 기록)
    // 상태 전이 규칙 검증
    @Transactional
    public void updateProductStatus(Long productId, ProductStatusUpdateDto dto) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));

        ProductStatus oldStatus = product.getStatus();
        ProductStatus newStatus = dto.getStatus();

        validateStatusTransition(oldStatus, newStatus);
        product.updateStatus(newStatus);

        ProductStatusHistory history = ProductStatusHistory.builder()
                .product(product)
                .oldStatus(oldStatus)
                .newStatus(newStatus)
                .changedBy(dto.getChangedBy())
                .build();

        historyRepository.save(history);
    }

    // 상태 전이 검증 로직
    private void validateStatusTransition(ProductStatus oldStatus, ProductStatus newStatus) {
        if (oldStatus == ProductStatus.APPROVED && newStatus == ProductStatus.INSPECTING) {
            throw new IllegalStateException("승인된 상품은 다시 검수중으로 변경할 수 없습니다.");
        }
        if (oldStatus == ProductStatus.DISCONTINUED && newStatus != ProductStatus.DISCONTINUED) {
            throw new IllegalStateException("단종된 상품은 상태를 변경할 수 없습니다.");
        }
    }

    // 카테고리 존재하지 않으면 생성
    private Category findOrCreateCategory(String large, String medium, String small) {
        Category largeCategory = categoryRepository.findByNameAndParentIsNull(large)
                .orElseGet(() -> categoryRepository.save(
                        Category.builder().name(large).active(true).build()
                ));

        Category mediumCategory = categoryRepository.findByNameAndParent(medium, largeCategory)
                .orElseGet(() -> categoryRepository.save(
                        Category.builder().name(medium).parent(largeCategory).active(true).build()
                ));

        Category smallCategory = categoryRepository.findByNameAndParent(small, mediumCategory)
                .orElseGet(() -> categoryRepository.save(
                        Category.builder().name(small).parent(mediumCategory).active(true).build()
                ));

        return smallCategory;
    }

    // 상품 전체 조회
    public List<ProductReadDto> getProductList() {
        return productRepository.findAll().stream()
                .map(ProductReadDto::from)
                .collect(Collectors.toList());
    }

    // 상품 상세 조회
    public ProductReadDto getProductDetails(Long id) {
        return productRepository.findById(id)
                .map(ProductReadDto::from)
                .orElse(null);
    }
}
