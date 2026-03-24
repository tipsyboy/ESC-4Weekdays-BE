package com.fourweekdays.fourweekdays.product.es;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/products/search")
public class ProductSearchController {

    private final ProductSearchService productSearchService;

    @PostMapping("/reindex")
    public ResponseEntity<BaseResponse<Integer>> reindexProducts() {
        return ResponseEntity.ok(BaseResponse.success(productSearchService.reindexProducts()));
    }
}
