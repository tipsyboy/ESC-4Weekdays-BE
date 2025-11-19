package com.fourweekdays.fourweekdays.inventory.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
import com.fourweekdays.fourweekdays.inventory.model.dto.response.ProductInventoryResponse;
import com.fourweekdays.fourweekdays.inventory.service.InventorySearchService;
import com.fourweekdays.fourweekdays.inventory.service.InventoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/inventories")
@RequiredArgsConstructor
@RestController
public class InventoryController {

    private final InventoryService inventoryService;
    private final InventorySearchService inventorySearchService;

    @PostMapping("/search")
    public ResponseEntity<BaseResponse<Page<ProductInventoryResponse>>> inventoriesByProduct(@RequestParam(defaultValue = "0") int page,
                                                                                             @RequestParam(defaultValue = "10") int size,
                                                                                             @RequestBody InventorySearchRequest request) {
        return ResponseEntity.ok(BaseResponse.success(inventoryService.searchInventoryByProduct(request, page, size)));
    }

    @PostMapping("/search/es")
    public ResponseEntity<BaseResponse<Page<ProductInventoryResponse>>> searchInventories(@RequestParam(defaultValue = "0") int page,
                                                                                          @RequestParam(defaultValue = "10") int size,
                                                                                          @RequestBody InventorySearchRequest searchRequest) {
        return ResponseEntity.ok(BaseResponse.success(inventorySearchService.searchInventoryByProduct(searchRequest, page, size)));
    }

    // 재고 상세 조회
    @GetMapping("/{productCode}")
    public ResponseEntity<BaseResponse<ProductInventoryResponse>> inventoryRead(@PathVariable String productCode) {
        return ResponseEntity.ok(BaseResponse.success(inventoryService.productInventoryDetail(productCode)));
    }

//    @PostMapping
//    public ResponseEntity<BaseResponse<Page<InventoryReadDto>>> inventoryList(@RequestParam(defaultValue = "0") int page,
//                                                                              @RequestParam(defaultValue = "10") int size,
//                                                                              @RequestBody InventorySearchRequest request) {
//        Page<InventoryReadDto> inventories = inventoryService.searchInventory(request, page, size);
//        return ResponseEntity.ok(BaseResponse.success(inventories));
//    }
}
