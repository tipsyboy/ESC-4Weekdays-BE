package com.fourweekdays.fourweekdays.purchaseorder.controller;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderCreateRequest;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderDetailResponse;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderListResponse;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderSearchCondition;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderStatusUpdateRequest;
import com.fourweekdays.fourweekdays.purchaseorder.service.PurchaseOrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
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
@RequestMapping("/api/purchase-orders")
@RequiredArgsConstructor
public class PurchaseOrderController {

    private final PurchaseOrderService purchaseOrderService;

    @GetMapping
    public ResponseEntity<BaseResponse<Page<PurchaseOrderListResponse>>> readAll(@ModelAttribute PurchaseOrderSearchCondition condition) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.search(condition)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<PurchaseOrderDetailResponse>> read(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.read(id)));
    }

    @PostMapping
    public ResponseEntity<BaseResponse<PurchaseOrderDetailResponse>> create(@Valid @RequestBody PurchaseOrderCreateRequest request) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.create(request)));
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<BaseResponse<PurchaseOrderDetailResponse>> updateStatus(
            @PathVariable Long id,
            @Valid @RequestBody PurchaseOrderStatusUpdateRequest request
    ) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.updateStatus(id, request)));
    }
}
