package com.fourweekdays.fourweekdays.product.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.common.BaseResponseStatus;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductCreateDto;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductUpdateDto;
import com.fourweekdays.fourweekdays.product.model.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.service.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    // 상품 등록
    @PostMapping
    public ResponseEntity<BaseResponse<Long>> register(@Valid @RequestBody ProductCreateDto dto) {
        Long saveId = productService.createProduct(dto);
        return ResponseEntity.ok(BaseResponse.success(saveId));
    }

    // 상품 전체 조회
    @GetMapping
    public ResponseEntity<BaseResponse<List<ProductReadDto>>> getProductList() {
        List<ProductReadDto> productList = productService.getProductList();
        return ResponseEntity.ok(BaseResponse.success(productList));
    }

    // 상품 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<ProductReadDto>> getProductDetails(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(productService.getProductDetail(id)));
    }
    
    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<Long>> updateProduct(@PathVariable Long id,
                                                            @RequestBody ProductUpdateDto requestDto) {
        return ResponseEntity.ok(BaseResponse.success(productService.update(id, requestDto)));
    }


//    // 상품 상태 변경
//    @PatchMapping("/{id}")
//    public ResponseEntity<BaseResponse<ProductStatusResponseDto>> updateStatus(@PathVariable Long id, 
//                                                                               @RequestBody ProductStatusUpdateDto dto) {
//        ProductStatusHistory history = productservice.updateProductStatus(id, dto);
//        ProductStatusResponseDto response = ProductStatusResponseDto.from(history);
//        return ResponseEntity.ok(BaseResponse.success(response));
//    }
}
