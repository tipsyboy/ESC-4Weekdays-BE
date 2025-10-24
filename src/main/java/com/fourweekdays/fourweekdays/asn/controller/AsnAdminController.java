package com.fourweekdays.fourweekdays.asn.controller;

import com.fourweekdays.fourweekdays.asn.model.dto.response.AsnResponse;
import com.fourweekdays.fourweekdays.asn.service.AsnService;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/admin/asn")
@RequiredArgsConstructor
@RestController
public class AsnAdminController {

    private final AsnService asnService;

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
