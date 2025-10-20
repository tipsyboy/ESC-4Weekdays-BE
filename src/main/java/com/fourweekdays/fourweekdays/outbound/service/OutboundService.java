package com.fourweekdays.fourweekdays.outbound.service;

import com.fourweekdays.fourweekdays.outbound.model.dto.request.OutboundCreateDto;
import com.fourweekdays.fourweekdays.outbound.model.dto.response.OutboundReadDto;
import com.fourweekdays.fourweekdays.outbound.model.dto.response.OutboundStatusResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class OutboundService {

    // 출고 생성
    public Long createOutbound(OutboundCreateDto dto) {
        return null;
    }

    // 출고 승인
    public OutboundStatusResponse approveOutbound(Long id) {
        return null;
    }

    // 출고 거절
    public OutboundStatusResponse rejectOutbound(Long id) {
        return null;
    }

    // 출고 목록 조회
    public List<OutboundReadDto> getOutboundList() {
        return null;
    }

    // 출고 상세 조회
    public OutboundReadDto getOutboundDetails(Long id) {
        return null;
    }
}
