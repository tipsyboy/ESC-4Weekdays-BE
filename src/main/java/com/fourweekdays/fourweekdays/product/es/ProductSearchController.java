package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import com.fourweekdays.fourweekdays.product.es.dto.ProductSearchPageResponse;
import com.fourweekdays.fourweekdays.product.es.dto.ProductSearchResponse;
import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/products/search")
public class ProductSearchController {

    private final ProductSearchService productSearchService;

    @PostMapping("/reindex")
    public ResponseEntity<BaseResponse<Integer>> reindexProducts() {
        return ResponseEntity.ok(BaseResponse.success(productSearchService.reindexProducts()));
    }

    @GetMapping("/es")
    public ResponseEntity<BaseResponse<List<ProductSearchResponse>>> searchProducts(@RequestParam(defaultValue = "0") int page,
                                                                                    @RequestParam(defaultValue = "10") int size,
                                                                                    @ModelAttribute ProductSearchRequest request) {
        return ResponseEntity.ok(BaseResponse.success(productSearchService.searchProducts(request, page, size)));
    }

    @GetMapping("/es/page")
    public ResponseEntity<BaseResponse<ProductSearchPageResponse>> searchProductsPage(@RequestParam(defaultValue = "0") int page,
                                                                                      @RequestParam(defaultValue = "10") int size,
                                                                                      @ModelAttribute ProductSearchRequest request) {
        return ResponseEntity.ok(BaseResponse.success(productSearchService.searchProductsPage(request, page, size)));
    }
}
