package com.fourweekdays.fourweekdays.product.service;

import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductCreateDto;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductUpdateDto;
import com.fourweekdays.fourweekdays.product.model.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_DUPLICATION;
import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProductService {

    private static final String PRODUCT_CODE_PREFIX = "PRD";

    private final ProductRepository productRepository;
    private final VendorRepository vendorRepository;
    private final CodeGenerator codeGenerator;


    @Transactional
    public Long createProduct(ProductCreateDto requestDto) {
        Vendor vendor = vendorRepository.findById(requestDto.getVendorId())
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));

        if (productRepository.existsByVendorAndName(vendor, requestDto.getName())) {
            throw new ProductException(PRODUCT_DUPLICATION);
        }

        Product product = requestDto.toEntity(codeGenerator.generate(PRODUCT_CODE_PREFIX));
        product.mappingVendor(vendor); // 연관 관계 매핑 
        return productRepository.save(product).getId();
    }

    public ProductReadDto getProductDetail(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

        return ProductReadDto.from(product);
    }

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

    @Transactional
    public void delete(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));
        product.delete();
    }

    public Page<ProductReadDto> searchProduct(ProductSearchRequest request, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> products = productRepository.searchProducts(pageable, request);

        return products.map(ProductReadDto::from);
    }


    public Page<ProductReadDto> getProductList(int page, int size) {
        // TODO: 리팩토링 포인트 - HttpRequest가 Service 레이어까지 침범
        Pageable pageable = PageRequest.of(page, size);

        // RequestParam으로 전달된 vendorId 추출
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attrs != null ? attrs.getRequest() : null;

        Long vendorId = null;
        if (request != null && request.getParameter("vendorId") != null) {
            vendorId = Long.valueOf(request.getParameter("vendorId"));
        }

        Page<Product> productList;

        // vendorId가 존재하면 해당 벤더의 ACTIVE 상품만 조회
        if (vendorId != null) {
            productList = productRepository.findByVendorIdAndStatus(vendorId, ProductStatus.ACTIVE, pageable);
        }
        // vendorId 없으면 전체 ACTIVE 상품만 조회
        else {
            productList = productRepository.findByStatus(ProductStatus.ACTIVE, pageable);
        }

        return productList.map(ProductReadDto::from);
    }
}
