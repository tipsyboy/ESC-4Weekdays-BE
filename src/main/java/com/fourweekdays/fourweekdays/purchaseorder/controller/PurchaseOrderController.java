package com.fourweekdays.fourweekdays.purchaseorder.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderReadDto;
import com.fourweekdays.fourweekdays.purchaseorder.service.PurchaseOrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/api/purchase-orders")
@RequiredArgsConstructor
@RestController
public class PurchaseOrderController {

    private final PurchaseOrderService purchaseOrderService;

    @PostMapping
    public ResponseEntity<BaseResponse<Long>> purchaseRequest(@Valid @RequestBody PurchaseOrderCreateDto requestDto) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.create(requestDto)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<PurchaseOrderReadDto>> purchaseOrderDetail(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.findByPurchaseOrderId(id)));
    }

    @GetMapping
    public ResponseEntity<BaseResponse<Page<PurchaseOrderReadDto>>> purchaseOrderList(@RequestParam(defaultValue = "0") int page,
                                                                                      @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.findPurchaseOrderListByPaging(page, size)));
    }
}
