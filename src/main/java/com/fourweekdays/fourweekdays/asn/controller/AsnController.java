package com.fourweekdays.fourweekdays.asn.controller;

import com.fourweekdays.fourweekdays.asn.dto.AsnCreateRequest;
import com.fourweekdays.fourweekdays.asn.dto.AsnDetailResponse;
import com.fourweekdays.fourweekdays.asn.dto.AsnPageResponse;
import com.fourweekdays.fourweekdays.asn.dto.AsnStatusUpdateRequest;
import com.fourweekdays.fourweekdays.asn.service.AsnService;
import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/asns")
@RequiredArgsConstructor
public class AsnController {

    private final AsnService asnService;

    @GetMapping
    public BaseResponse<AsnPageResponse> readAll(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        return BaseResponse.success(asnService.readAll(page, size));
    }

    @GetMapping("/{id}")
    public BaseResponse<AsnDetailResponse> read(@PathVariable Long id) {
        return BaseResponse.success(asnService.read(id));
    }

    @GetMapping("/purchase-orders/{purchaseOrderId}")
    public BaseResponse<AsnDetailResponse> readByPurchaseOrderId(@PathVariable Long purchaseOrderId) {
        return BaseResponse.success(asnService.readByPurchaseOrderId(purchaseOrderId));
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public BaseResponse<AsnDetailResponse> create(@Valid @RequestBody AsnCreateRequest request) {
        return BaseResponse.success(asnService.create(request));
    }

    @PatchMapping("/{id}/status")
    public BaseResponse<AsnDetailResponse> updateStatus(
            @PathVariable Long id,
            @Valid @RequestBody AsnStatusUpdateRequest request
    ) {
        return BaseResponse.success(asnService.updateStatus(id, request));
    }
}
