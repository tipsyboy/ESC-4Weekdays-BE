package com.fourweekdays.fourweekdays.inbound.controller;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import com.fourweekdays.fourweekdays.inbound.dto.InboundCreateRequest;
import com.fourweekdays.fourweekdays.inbound.dto.InboundDetailResponse;
import com.fourweekdays.fourweekdays.inbound.dto.InboundPageResponse;
import com.fourweekdays.fourweekdays.inbound.dto.InboundReceiptUpdateRequest;
import com.fourweekdays.fourweekdays.inbound.dto.InboundReadDto;
import com.fourweekdays.fourweekdays.inbound.dto.InboundSearchRequest;
import jakarta.validation.Valid;
import com.fourweekdays.fourweekdays.inbound.service.InboundService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/inbounds")
@RequiredArgsConstructor
public class InboundController {

    private final InboundService inboundService;

    @GetMapping
    public ResponseEntity<BaseResponse<InboundPageResponse>> readAll(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size
    ) {
        return ResponseEntity.ok(BaseResponse.success(inboundService.readAll(page, size)));
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<BaseResponse<InboundDetailResponse>> createInbound(@Valid @RequestBody InboundCreateRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(BaseResponse.success(inboundService.create(request)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<InboundDetailResponse>> detailInbound(@PathVariable Long id) {
        return ResponseEntity.ok(BaseResponse.success(inboundService.read(id)));
    }

    @GetMapping("/asn/{asnId}")
    public ResponseEntity<BaseResponse<InboundDetailResponse>> readByAsnId(@PathVariable Long asnId) {
        return ResponseEntity.ok(BaseResponse.success(inboundService.readByAsnId(asnId)));
    }

    @PatchMapping("/{id}/receipt")
    public ResponseEntity<BaseResponse<InboundDetailResponse>> updateReceipt(
            @PathVariable Long id,
            @Valid @RequestBody InboundReceiptUpdateRequest request
    ) {
        return ResponseEntity.ok(BaseResponse.success(inboundService.updateReceipt(id, request)));
    }

    @PostMapping("/search")
    public ResponseEntity<BaseResponse<Page<InboundReadDto>>> searchInboundWithProduct(@RequestParam(defaultValue = "0") int page,
                                                                                       @RequestParam(defaultValue = "10") int size,
                                                                                       @RequestBody InboundSearchRequest request) {
        return ResponseEntity.ok(BaseResponse.success(inboundService.searchInbounds(page, size, request)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BaseResponse<String>> cancelInbound(@PathVariable Long id) {
        inboundService.cancel(id);
        return ResponseEntity.ok(BaseResponse.success("입고 취소"));
    }
}
