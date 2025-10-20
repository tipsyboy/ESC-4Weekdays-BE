package com.fourweekdays.fourweekdays.product.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductCreateDto;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductUpdateDto;
import com.fourweekdays.fourweekdays.product.model.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.service.ProductService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequiredArgsConstructor
@RequestMapping("/api/products")
public class ProductController {

    private final ProductService productService;

    @PostMapping
    public ResponseEntity<BaseResponse<Long>> register(@Valid @RequestBody ProductCreateDto dto) {
        Long saveId = productService.createProduct(dto);
        return ResponseEntity.ok(BaseResponse.success(saveId));
    }

    @GetMapping
    public ResponseEntity<BaseResponse<Page<ProductReadDto>>> getProductList(@RequestParam(defaultValue = "0") int page,
                                                                             @RequestParam(defaultValue = "10") int size) {
        Page<ProductReadDto> productList = productService.getProductList(page, size);
        return ResponseEntity.ok(BaseResponse.success(productList));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<ProductReadDto>> getProductDetails(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(productService.getProductDetail(id)));
    }
    
    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<Long>> updateProduct(@PathVariable Long id,
                                                            @RequestBody ProductUpdateDto requestDto) {
        return ResponseEntity.ok(BaseResponse.success(productService.update(id, requestDto)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BaseResponse<String>> deleteProduct(@PathVariable Long id) {
        productService.delete(id);
        return ResponseEntity.ok(BaseResponse.success("품절 상태로 변경"));
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
