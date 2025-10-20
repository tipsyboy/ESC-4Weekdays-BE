package com.fourweekdays.fourweekdays.product.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.common.BaseResponseStatus;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.exception.ProductExceptionType;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductCreateDto;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductUpdateDto;
import com.fourweekdays.fourweekdays.product.model.dto.response.ProductReadDto;
import com.fourweekdays.fourweekdays.product.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/product")
public class ProductController {

    private final ProductService productService;

    // 상품 등록 (파일 업로드 추가)
    @PostMapping(consumes = {"multipart/form-data"})
    public ResponseEntity<BaseResponse<Long>> register(
            @RequestPart("dto") String dtoJson,
            @RequestPart(value = "files", required = false) List<MultipartFile> files) {

        try {
            ObjectMapper mapper = new ObjectMapper();
            ProductCreateDto dto = mapper.readValue(dtoJson, ProductCreateDto.class);

            Long saveId = productService.createProduct(dto, files);
            return ResponseEntity.ok(BaseResponse.success(saveId));

        } catch (Exception e) {
            throw new ProductException(ProductExceptionType.PRODUCT_REGISTER_FAILED, e);
        }
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
        ProductReadDto productDto = productService.getProductDetails(id);
        if (productDto == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(BaseResponse.error(BaseResponseStatus.PRODUCT_NOT_FOUND));
        }
        return ResponseEntity.ok(BaseResponse.success(productDto));
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
