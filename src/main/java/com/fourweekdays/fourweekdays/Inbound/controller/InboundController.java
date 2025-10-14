package com.fourweekdays.fourweekdays.Inbound.controller;

import com.fourweekdays.fourweekdays.Inbound.model.dto.request.InboundCreateDto;
import com.fourweekdays.fourweekdays.Inbound.model.dto.request.InboundUpdateDto;
import com.fourweekdays.fourweekdays.Inbound.model.dto.response.InboundListDto;
import com.fourweekdays.fourweekdays.Inbound.model.dto.response.InboundReadDto;
import com.fourweekdays.fourweekdays.Inbound.service.InboundService;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/inbound")
@RequiredArgsConstructor
public class InboundController {
    private final InboundService inboundService;

    // 응답 방식 결정되면 그거 따라서 변경하기
    @PostMapping
    public ResponseEntity<BaseResponse<Long>> createInbound(@RequestBody InboundCreateDto dto) {
        Long result = inboundService.create(dto);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 입고 목록 조회
    @GetMapping("/list")
    public ResponseEntity<BaseResponse<List<InboundListDto>>> listInbound(Integer page, Integer size) {
        List<InboundListDto> result = inboundService.list(page, size);
        return ResponseEntity.ok(BaseResponse.success(result));
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
