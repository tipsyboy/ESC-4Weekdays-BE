package com.fourweekdays.fourweekdays.inventory.controller;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import com.fourweekdays.fourweekdays.inventory.domain.InventoryStatus;
import com.fourweekdays.fourweekdays.inventory.dto.InventoryDetailResponse;
import com.fourweekdays.fourweekdays.inventory.dto.InventoryListResponse;
import com.fourweekdays.fourweekdays.inventory.dto.InventoryMapLocationResponse;
import com.fourweekdays.fourweekdays.inventory.dto.InventorySearchCondition;
import com.fourweekdays.fourweekdays.inventory.service.InventoryService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/inventories")
@RequiredArgsConstructor
public class InventoryController {

    private final InventoryService inventoryService;

    @GetMapping
    public ResponseEntity<BaseResponse<List<InventoryListResponse>>> readAll(
            @RequestParam(required = false) String productCode,
            @RequestParam(required = false) String productName,
            @RequestParam(required = false) String locationCode,
            @RequestParam(required = false) String zoneCode,
            @RequestParam(required = false) InventoryStatus status
    ) {
        return ResponseEntity.ok(BaseResponse.success(inventoryService.readAll(new InventorySearchCondition(
                productCode,
                productName,
                locationCode,
                zoneCode,
                status
        ))));
    }

    @GetMapping("/map")
    public ResponseEntity<BaseResponse<List<InventoryMapLocationResponse>>> readMap() {
        return ResponseEntity.ok(BaseResponse.success(inventoryService.readMap()));
    }

    @GetMapping("/{productId}")
    public ResponseEntity<BaseResponse<InventoryDetailResponse>> read(@PathVariable Long productId) {
        return ResponseEntity.ok(BaseResponse.success(inventoryService.read(productId)));
    }
}
