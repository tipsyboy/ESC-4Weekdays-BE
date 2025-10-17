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

    public Long createOutbound(OutboundCreateDto dto) {
        return null;
    }

    public OutboundStatusResponse approveOutbound(Long id) {
        return null;
    }

    public OutboundStatusResponse rejectOutbound(Long id) {
        return null;
    }

    public List<OutboundReadDto> getOutboundList() {
        return null;
    }

    public OutboundReadDto getOutboundDetails(Long id) {
        return null;
    }
}
