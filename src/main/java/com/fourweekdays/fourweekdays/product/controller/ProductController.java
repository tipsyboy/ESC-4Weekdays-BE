package com.fourweekdays.fourweekdays.product.controller;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import com.fourweekdays.fourweekdays.global.response.PageResponse;
import com.fourweekdays.fourweekdays.product.dto.ProductCreateRequest;
import com.fourweekdays.fourweekdays.product.dto.ProductDetailResponse;
import com.fourweekdays.fourweekdays.product.dto.ProductListResponse;
import com.fourweekdays.fourweekdays.product.dto.ProductSearchCondition;
import com.fourweekdays.fourweekdays.product.dto.ProductStatusUpdateRequest;
import com.fourweekdays.fourweekdays.product.dto.ProductUpdateRequest;
import com.fourweekdays.fourweekdays.product.service.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    @GetMapping
    public ResponseEntity<BaseResponse<PageResponse<ProductListResponse>>> readAll(@ModelAttribute ProductSearchCondition condition) {
        return ResponseEntity.ok(BaseResponse.success(PageResponse.from(productService.search(condition))));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<ProductDetailResponse>> read(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(productService.read(id)));
    }

    @PostMapping
    public ResponseEntity<BaseResponse<ProductDetailResponse>> create(@Valid @RequestBody ProductCreateRequest request) {
        return ResponseEntity.ok(BaseResponse.success(productService.create(request)));
    }

    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<ProductDetailResponse>> update(@PathVariable Long id,
                                                                      @Valid @RequestBody ProductUpdateRequest request) {
        return ResponseEntity.ok(BaseResponse.success(productService.update(id, request)));
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<BaseResponse<ProductDetailResponse>> updateStatus(
            @PathVariable Long id,
            @Valid @RequestBody ProductStatusUpdateRequest request
    ) {
        return ResponseEntity.ok(BaseResponse.success(productService.updateStatus(id, request)));
    }
}
