package com.fourweekdays.fourweekdays.purchaseorder.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.service.PurchaseOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/purchase")
@RequiredArgsConstructor
@RestController
public class PurchaseOrderController {

    private final PurchaseOrderService purchaseOrderService;

    @PostMapping
    public ResponseEntity<BaseResponse<Long>> purchaseRequest(@RequestBody PurchaseOrderCreateDto requestDto) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.create(requestDto)));
    }


}
