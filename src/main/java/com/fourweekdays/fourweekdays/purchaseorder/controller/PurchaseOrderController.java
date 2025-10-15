package com.fourweekdays.fourweekdays.purchaseorder.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderReadDto;
import com.fourweekdays.fourweekdays.purchaseorder.service.PurchaseOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/api/purchase-orders")
@RequiredArgsConstructor
@RestController
public class PurchaseOrderController {

    private final PurchaseOrderService purchaseOrderService;

    @PostMapping
    public ResponseEntity<BaseResponse<Long>> purchaseRequest(@RequestBody PurchaseOrderCreateDto requestDto) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.create(requestDto)));
    }

    @GetMapping
    public ResponseEntity<BaseResponse<List<PurchaseOrderReadDto>>> purchaseOrderList() {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.findAll()));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<PurchaseOrderReadDto>> purchaseOrderDetail(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.findByPurchaseOrderId(id)));
    }
}
