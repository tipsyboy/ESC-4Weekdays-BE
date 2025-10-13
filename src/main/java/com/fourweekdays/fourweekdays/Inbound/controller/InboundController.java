package com.fourweekdays.fourweekdays.Inbound.controller;

import com.fourweekdays.fourweekdays.Inbound.model.dto.request.InboundCreateDto;
import com.fourweekdays.fourweekdays.Inbound.model.dto.request.InboundUpdateDto;
import com.fourweekdays.fourweekdays.Inbound.service.InboundService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/inbound")
@RequiredArgsConstructor
public class InboundController {
    private final InboundService inboundService;

    // 응답 방식 결정되면 그거 따라서 변경하기
    @PostMapping("/")
    public String createInbound(@RequestBody InboundCreateDto dto) {
        inboundService.create(dto);
        return "success";
    }

    // 입고 목록 조회
    @GetMapping("/")
    public String listInbound(Integer page, Integer size) {
        inboundService.list(page, size);
        return "success";
    }

    @GetMapping("/")
    public String detailInbound(@RequestParam Integer id) {
        inboundService.detail(id);
        return "success";
    }

    // 입고 수정
    @PostMapping("/")
    public String updateInbound(@RequestBody InboundUpdateDto dto) {
        inboundService.update(dto);
        return "success";
    }

    // 입고 삭제
    @GetMapping("/")
    public String deleteInbound(@RequestParam Integer id) {
        inboundService.hardDelete(id);
//        inboundService.softDelete(dto);
        return "success";
    }
}
