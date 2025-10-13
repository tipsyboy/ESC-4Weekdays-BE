package com.fourweekdays.fourweekdays.product.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.common.BaseResponseStatus;
import com.fourweekdays.fourweekdays.product.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.dto.request.ProductCreateDto;
import com.fourweekdays.fourweekdays.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/product")
public class ProductController {
    private final ProductService productservice;

    // 상품 등록
    @PostMapping
    public ResponseEntity<BaseResponse<String>> register(@RequestBody ProductCreateDto dto) {
        productservice.register(dto);
        return ResponseEntity.ok(BaseResponse.success("등록 완료"));
    }

    // 상품 전체 조회
    @GetMapping
    public ResponseEntity<BaseResponse<List<ProductReadDto>>> getProductList() {
        List<ProductReadDto> productList = productservice.getProductList();
        return ResponseEntity.ok(BaseResponse.success(productList));
    }

    // 상품 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<ProductReadDto>> getProductDetails(@PathVariable Long id) {
        ProductReadDto productDto = productservice.getProductDetails(id);
        if (productDto == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(BaseResponse.error(BaseResponseStatus.PRODUCT_NOT_FOUND));
        }
        return ResponseEntity.ok(BaseResponse.success(productDto));
    }
}
