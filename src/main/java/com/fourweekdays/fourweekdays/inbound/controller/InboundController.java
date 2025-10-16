package com.fourweekdays.fourweekdays.inbound.controller;

import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundCreateDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundUpdateDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.response.InboundListDto;
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
    public ResponseEntity<BaseResponse<Long>> createInbound(@RequestBody InboundCreateDto dto) {
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
        InboundReadDto result = inboundService.detail(id);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 입고 수정
    @PostMapping("/update")
    public ResponseEntity<BaseResponse<Long>> updateInbound(@RequestBody InboundUpdateDto dto) {
        Long result = inboundService.update(dto);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 입고 삭제
    @GetMapping("/delete")
    public ResponseEntity<BaseResponse<String>> deleteInbound(@RequestParam Long id) {
        inboundService.hardDelete(id);
//        inboundService.softDelete(dto);
        return ResponseEntity.ok(BaseResponse.success("success"));
    }
}
