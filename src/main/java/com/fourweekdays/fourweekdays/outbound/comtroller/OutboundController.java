package com.fourweekdays.fourweekdays.outbound.comtroller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.common.BaseResponseStatus;
import com.fourweekdays.fourweekdays.outbound.model.dto.request.OutboundCreateDto;
import com.fourweekdays.fourweekdays.outbound.model.dto.response.OutboundReadDto;
import com.fourweekdays.fourweekdays.outbound.model.dto.response.OutboundStatusResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/outboud")
public class OutboundController {

    private final OutboundService outboundService;

    // 출고 요청(출고서 등록)
    @PostMapping
    public ResponseEntity<BaseResponse<Long>> require(@RequestBody OutboundCreateDto dto) {
        Long saveId = outboundService.createOutbound(dto);
        return ResponseEntity.ok(BaseResponse.success(saveId));
  [[]]  }

    // 출고 승인
    @PostMapping("/{id}/approve")
    public ResponseEntity<BaseResponse<OutboundStatusResponse>> approveOutbound(@PathVariable Long id) {
        OutboundStatusResponse result = outboundService.approveOutbound(id);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 출고 거절
    @PostMapping("/{id}/reject")
    public ResponseEntity<BaseResponse<OutboundStatusResponse>> rejectOutbound(@PathVariable Long id) {
        OutboundStatusResponse result = outboundService.rejectOutbound(id);
        return ResponseEntity.ok(BaseResponse.success(result));
    }

    // 출고서 전체 조회
    @GetMapping
    public ResponseEntity<BaseResponse<List<OutboundReadDto>>> getOutboundList() {
        List<OutboundReadDto> outboundList = outboundService.getOutboundList();
        return ResponseEntity.ok(BaseResponse.success(outboundList));
    }

    // 출고서 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<BaseResponse<OutboundReadDto>> getOutboundDetails(@PathVariable Long id) {
        OutboundReadDto outboundDto = outboundService.getOutboundDetails(id);
        if (outboundDto == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(BaseResponse.error(BaseResponseStatus.OUTBOUND_NOT_FOUND));
        }
        return ResponseEntity.ok(BaseResponse.success(outboundDto));
    }
}
