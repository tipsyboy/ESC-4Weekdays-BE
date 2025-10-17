package com.fourweekdays.fourweekdays.inbound.controller;

import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundCreateRequestDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundUpdateRequestDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.response.InboundReadDto;
import com.fourweekdays.fourweekdays.inbound.service.InboundService;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/inbounds")
@RequiredArgsConstructor
public class InboundController {

    private final InboundService inboundService;

    @PostMapping
    public ResponseEntity<BaseResponse<Long>> createInbound(@RequestBody InboundCreateRequestDto dto) {
        Long result = inboundService.create(dto);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 입고 목록 조회
    @GetMapping("/list")
    public ResponseEntity<BaseResponse<List<InboundReadDto>>> listInbound(Integer page, Integer size) {
//        List<InboundReadDto> result = inboundService.list(page, size);
        List<InboundReadDto> mockData = new ArrayList<>();
        return ResponseEntity.ok(BaseResponse.success(mockData));
    }

    // 입고 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<InboundReadDto>> detailInbound(@PathVariable Long id) {
        InboundReadDto result = inboundService.inboundDetail(id);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 입고 수정
    @PatchMapping("/{id}")
    public ResponseEntity<BaseResponse<Long>> updateInbound(@RequestBody InboundUpdateRequestDto dto,
                                                            @PathVariable Long id) {
        Long result = inboundService.update(dto, id);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 입고 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<BaseResponse<String>> deleteInbound(@PathVariable Long id) {
        inboundService.softDelete(id);
        return ResponseEntity.ok(BaseResponse.success("success"));
    }
}
