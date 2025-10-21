package com.fourweekdays.fourweekdays.franchise.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.franchise.model.dto.request.FranchiseCreateDto;
import com.fourweekdays.fourweekdays.franchise.service.FranchiseService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/franchises")
@RequiredArgsConstructor
public class FranchiseController {

    private final FranchiseService franchiseService;

    @PostMapping
    public ResponseEntity<BaseResponse<Long>> FranchiseCreate(@RequestBody FranchiseCreateDto dto) {
        Long result = franchiseService.create(dto);
        return ResponseEntity.ok(BaseResponse.success(result));
    }
}
