package com.fourweekdays.fourweekdays.product.service;

import com.fourweekdays.fourweekdays.image.service.ImageService;
import com.fourweekdays.fourweekdays.product.exception.ProductExceptionType;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductCreateDto;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductUpdateDto;
import com.fourweekdays.fourweekdays.product.model.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProductService {

    private final ProductRepository productRepository;
    private final VendorRepository vendorRepository;
    private final ImageService imageService;
//    private final CategoryRepository categoryRepository;
//    private final ProductStatusHistoryRepository historyRepository;

    // 상품 등록
    @Transactional
    public Long createProduct(ProductCreateDto requestDto, List<MultipartFile> files) {
        log.info("[productService] 상품 등록 요청 시작 - DTO: {}", requestDto);
        try {
            Vendor vendor = vendorRepository.findById(requestDto.getVendorId())
                    .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));
            log.info("[ProductService] Vendor 조회 완료: {}", vendor.getName());


            // TODO: 같은 상품이 있는지 판단하는 로직
            Product product = requestDto.toEntity();
            product.mappingVendor(vendor); // 연관 관계 매핑

            // 상품 DB 저장
            Product savedProduct = productRepository.save(product);
            log.info("[ProductService] 상품 저장 완료 - ID: {}", savedProduct.getId());

            // 이미지 업로드 & DB 저장
            if (files != null && !files.isEmpty()) {
                log.info("[ProductService] 이미지 업로드 시작 - 파일 수: {}", files.size());
                imageService.upload(savedProduct, files);
                log.info("[ProductService] 이미지 업로드 완료");
            } else {
                log.info("[ProductService] 업로드할 이미지가 없습니다.");
            }
            log.info("[ProductService] 상품 등록 완료 - ID: {}", savedProduct.getId());
            return productRepository.save(product).getId();
        } catch (Exception e) {
            log.error("[ProductService] 상품 등록 중 예외 발생", e);
            throw new ProductException(ProductExceptionType.PRODUCT_REGISTER_FAILED, e);
        }

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

    // 상품 수정
    @Transactional
    public Long update(Long id, ProductUpdateDto requestDto) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

        vendorRepository.findById(requestDto.getVendorId())
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));

        product.update(requestDto.getName(), requestDto.getUnit(),
                requestDto.getUnitPrice(), requestDto.getDescription(),
                requestDto.getStatus(), product.getVendor()
        );

        return id;
    }


//    @Transactional
//    public Long register(ProductCreateDto dto) {
//        Category category = null;
//
//        // categoryId 존재 시 → 기존 카테고리 연결
//        if (dto.getCategoryId() != null) {
//            category = categoryRepository.findById(dto.getCategoryId())
//                    .orElseThrow(() -> new RuntimeException("해당 카테고리를 찾을 수 없습니다."));
//        }
//
//        // categoryId 없고 이름 정보(categoryLarge~Small)만 있을 경우 → 카테고리 생성 or 조회
//        else if (dto.getCategoryLarge() != null && dto.getCategoryMedium() != null && dto.getCategorySmall() != null) {
//            category = findOrCreateCategory(dto.getCategoryLarge(), dto.getCategoryMedium(), dto.getCategorySmall());
//        }
//
//        // 상품 생성 및 저장
//        Product product = dto.toEntity(category);
//        product.updateStatus(ProductStatus.RECEIVED); // 기본 상태: 입고(RECEIVED)
//        Product saved = productRepository.save(product);
//
//        // 최초 상태 이력 기록
//        ProductStatusHistory history = ProductStatusHistory.builder()
//                .product(saved)
//                .oldStatus(null)
//                .newStatus(ProductStatus.RECEIVED)
//                .changedBy("SYSTEM") // 작업자 ID or 이름 등 정보 필요
//                .build();
//
//        historyRepository.save(history);
//
//        return saved.getId();
//    }

//    // 상태 변경(변경시 ProductStatusHistory에 기록)
//    // 상태 전이 규칙 검증
//    @Transactional
//    public ProductStatusHistory updateProductStatus(Long productId, ProductStatusUpdateDto dto) {
//        Product product = productRepository.findById(productId)
//                .orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
//
//        ProductStatus oldStatus = product.getStatus();
//        ProductStatus newStatus = dto.getStatus();
//
//        validateStatusTransition(oldStatus, newStatus);
//        product.updateStatus(newStatus);
//
//        ProductStatusHistory history = ProductStatusHistory.builder()
//                .product(product)
//                .oldStatus(oldStatus)
//                .newStatus(newStatus)
//                .changedBy(dto.getChangedBy())
//                .build();
//
//        return historyRepository.save(history);
//    }

//    // 상태 전이 검증 로직
//    private void validateStatusTransition(ProductStatus oldStatus, ProductStatus newStatus) {
//        if (oldStatus == ProductStatus.APPROVED) {
//            throw new IllegalStateException("승인된 상품은 더 이상 상태를 변경할 수 없습니다.");
//        }
//        if (oldStatus == ProductStatus.RECEIVED && newStatus != ProductStatus.INSPECTING) {
//            throw new IllegalStateException("입고 상태에서는 검수중으로만 이동할 수 있습니다.");
//        }
//        if (oldStatus == ProductStatus.INSPECTING && newStatus != ProductStatus.INSPECTED) {
//            throw new IllegalStateException("검수중 상태에서는 검수 완료로만 이동할 수 있습니다.");
//        }
//        if (oldStatus == ProductStatus.INSPECTED && newStatus != ProductStatus.STORING) {
//            throw new IllegalStateException("검수 완료 상태에서는 적치중으로만 이동할 수 있습니다.");
//        }
//        if (oldStatus == ProductStatus.STORING && newStatus != ProductStatus.APPROVED) {
//            throw new IllegalStateException("적치중 상태에서는 승인으로만 이동할 수 있습니다.");
//        }
//    }

//    // 카테고리 존재하지 않으면 생성
//    private Category findOrCreateCategory(String large, String medium, String small) {
//        Category largeCategory = categoryRepository.findByNameAndParentIsNull(large)
//                .orElseGet(() -> categoryRepository.save(
//                        Category.builder().name(large).active(true).build()
//                ));
//
//        Category mediumCategory = categoryRepository.findByNameAndParent(medium, largeCategory)
//                .orElseGet(() -> categoryRepository.save(
//                        Category.builder().name(medium).parent(largeCategory).active(true).build()
//                ));
//
//        Category smallCategory = categoryRepository.findByNameAndParent(small, mediumCategory)
//                .orElseGet(() -> categoryRepository.save(
//                        Category.builder().name(small).parent(mediumCategory).active(true).build()
//                ));
//
//        return smallCategory;
//    }

}
