package com.fourweekdays.fourweekdays.asn.controller;

import com.fourweekdays.fourweekdays.asn.annotation.AuthenticatedVendor;
import com.fourweekdays.fourweekdays.asn.model.dto.request.AsnReceiveRequest;
import com.fourweekdays.fourweekdays.asn.model.dto.request.PurchaseOrderRejectRequest;
import com.fourweekdays.fourweekdays.asn.model.dto.response.AsnResponse;
import com.fourweekdays.fourweekdays.asn.service.AsnService;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/asn")
@RequiredArgsConstructor
@RestController
public class AsnController {

    private final AsnService asnService;

    @PostMapping
    public ResponseEntity<BaseResponse<String>> receiveAsn(@AuthenticatedVendor Vendor vendor,
                                                           @RequestBody AsnReceiveRequest request) {
        asnService.receiveAsn(vendor, request);
        return ResponseEntity.ok(BaseResponse.success("발주 ASN 전송 성공"));
    }

    @PostMapping("/reject")
    public ResponseEntity<BaseResponse<String>> rejectPurchaseOrder(@AuthenticatedVendor Vendor vendor,
                                                                    @RequestBody PurchaseOrderRejectRequest request) {
        asnService.rejectPurchaseOrderByVendor(vendor, request);
        return ResponseEntity.ok(BaseResponse.success("배송 취소"));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<AsnResponse>> asnDetail(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(asnService.asnDetail(id)));
    }

    @GetMapping
    public ResponseEntity<BaseResponse<Page<AsnResponse>>> asnList(@RequestParam(defaultValue = "0") int page,
                                                                   @RequestParam(defaultValue = "10") int size) {
        return ResponseEntity.ok(BaseResponse.success(asnService.asnListByPaging(page, size)));
    }
}
