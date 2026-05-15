package com.fourweekdays.fourweekdays.product.service;

import com.fourweekdays.fourweekdays.global.util.CodeGenerator;
import com.fourweekdays.fourweekdays.global.util.CodeType;
import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.product.dto.ProductCreateRequest;
import com.fourweekdays.fourweekdays.product.dto.ProductDetailResponse;
import com.fourweekdays.fourweekdays.product.dto.ProductListResponse;
import com.fourweekdays.fourweekdays.product.dto.ProductSearchCondition;
import com.fourweekdays.fourweekdays.product.dto.ProductStatusUpdateRequest;
import com.fourweekdays.fourweekdays.product.dto.ProductUpdateRequest;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_DUPLICATION;
import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProductService {

    private final ProductRepository productRepository;
    private final VendorRepository vendorRepository;
    private final CodeGenerator codeGenerator;

    @Transactional
    public ProductDetailResponse create(ProductCreateRequest request) {
        Vendor vendor = findVendor(request.vendorId());

        if (productRepository.existsByVendorAndName(vendor, request.name())) {
            throw new ProductException(PRODUCT_DUPLICATION);
        }

        Product product = Product.builder()
                .productCode(codeGenerator.generate(CodeType.PRODUCT))
                .name(request.name())
                .category(request.category())
                .unitPrice(request.unitPrice())
                .boxQuantity(request.boxQuantity())
                .stockQuantity(request.stockQuantity())
                .safetyStock(request.safetyStock())
                .leadTimeDays(request.leadTimeDays())
                .status(request.status())
                .description(request.description())
                .vendor(vendor)
                .build();

        return ProductDetailResponse.from(productRepository.save(product));
    }

    public Page<ProductListResponse> search(ProductSearchCondition condition) {
        Pageable pageable = PageRequest.of(
                condition.pageOrDefault(),
                condition.sizeOrDefault(),
                Sort.by(
                        Sort.Direction.fromString(condition.sortDirectionOrDefault()),
                        resolveSortBy(condition.sortByOrDefault())
                )
        );

        return productRepository.search(
                        normalizeText(condition.vendorName()),
                        normalizeText(condition.productCode()),
                        normalizeText(condition.productName()),
                        normalizeText(condition.category()),
                        condition.status(),
                        pageable
                )
                .map(ProductListResponse::from);
    }

    public ProductDetailResponse read(Long id) {
        return ProductDetailResponse.from(findProduct(id));
    }

    @Transactional
    public ProductDetailResponse update(Long id, ProductUpdateRequest request) {
        Product product = findProduct(id);
        Vendor vendor = findVendor(request.vendorId());

        product.update(
                request.name(),
                request.category(),
                request.unitPrice(),
                request.boxQuantity(),
                request.stockQuantity(),
                request.safetyStock(),
                request.leadTimeDays(),
                request.status(),
                request.description(),
                vendor
        );

        return ProductDetailResponse.from(product);
    }

    @Transactional
    public ProductDetailResponse updateStatus(Long id, ProductStatusUpdateRequest request) {
        Product product = findProduct(id);
        product.changeStatus(request.status());
        return ProductDetailResponse.from(product);
    }

    private Product findProduct(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));
    }

    private Vendor findVendor(Long id) {
        return vendorRepository.findById(id)
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));
    }

    private String resolveSortBy(String sortBy) {
        if (sortBy == null || sortBy.isBlank()) {
            return "updatedAt";
        }

        return switch (sortBy) {
            case "name", "createdAt", "updatedAt", "productCode", "status" -> sortBy;
            default -> "updatedAt";
        };
    }

    private String normalizeText(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim();
    }
}
