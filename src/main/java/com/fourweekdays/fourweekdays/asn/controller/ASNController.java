package com.fourweekdays.fourweekdays.asn.controller;

import com.fourweekdays.fourweekdays.asn.annotation.AuthenticatedVendor;
import com.fourweekdays.fourweekdays.asn.model.dto.request.AsnReceiveRequest;
import com.fourweekdays.fourweekdays.asn.service.AsnService;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/api/asn")
@RequiredArgsConstructor
@RestController
public class ASNController {

    private final AsnService asnService;

    @PostMapping
    public ResponseEntity<BaseResponse<String>> receiveAsn(@AuthenticatedVendor Vendor vendor,
                                                           @RequestBody AsnReceiveRequest request) {
        asnService.receiveAsn(vendor, request);
        return ResponseEntity.ok(BaseResponse.success("발주 ASN 전송 성공"));
    }
}
