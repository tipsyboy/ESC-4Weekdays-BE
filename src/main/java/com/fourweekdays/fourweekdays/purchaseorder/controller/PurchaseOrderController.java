package com.fourweekdays.fourweekdays.purchaseorder.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.member.model.UserAuth;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderUpdateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderReadDto;
import com.fourweekdays.fourweekdays.purchaseorder.service.PurchaseOrderService;
import jakarta.mail.MessagingException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/api/purchase-orders")
@RequiredArgsConstructor
@RestController
public class PurchaseOrderController {

    private final PurchaseOrderService purchaseOrderService;

    @PostMapping
    public ResponseEntity<BaseResponse<Long>> purchaseRequest(@Valid @RequestBody PurchaseOrderCreateDto requestDto,
                                                              @AuthenticationPrincipal UserAuth manager) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.create(requestDto, manager.getId())));
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

    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<Long>> updatePurchaseOrder(@PathVariable Long id,
                                                                  @Valid @RequestBody PurchaseOrderUpdateDto requestDto) {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.update(id, requestDto)));
    }

    @PostMapping("/{id}/approve")
    public ResponseEntity<BaseResponse<Long>> approvePurchaseOrder(@PathVariable Long id) throws MessagingException {
        return ResponseEntity.ok(BaseResponse.success(purchaseOrderService.approve(id)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BaseResponse<String>> cancelOrder(@PathVariable Long id) {
        purchaseOrderService.cancel(id);
        return ResponseEntity.ok((BaseResponse.success("발주 취소")));
    }
}
