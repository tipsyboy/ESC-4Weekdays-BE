package com.fourweekdays.fourweekdays.Inbound.service;

import com.fourweekdays.fourweekdays.Inbound.model.dto.request.InboundCreateDto;
import com.fourweekdays.fourweekdays.Inbound.model.dto.request.InboundDeleteDto;
import com.fourweekdays.fourweekdays.Inbound.model.dto.request.InboundUpdateDto;
import com.fourweekdays.fourweekdays.Inbound.model.dto.response.InboundReadDto;
import com.fourweekdays.fourweekdays.Inbound.model.dto.response.InboundListDto;
import com.fourweekdays.fourweekdays.Inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.Inbound.repository.InboundRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class InboundService {
    private final InboundRepository inboundRepository;

    public Long create(InboundCreateDto dto) {
        Inbound result = inboundRepository.save(dto.toEntity());
        return result.getId();
    }

    public List<InboundListDto> list(Integer page, Integer size) {
        Page<Inbound> result = inboundRepository.findAll(PageRequest.of(page, size));
        return result.stream().map(InboundListDto::from).toList();
    }

    public InboundReadDto detail(Long id) {
        Inbound entity = inboundRepository.findById(id).orElseThrow();
        return InboundReadDto.from(entity);
    }

    public Long update(InboundUpdateDto dto) {
        inboundRepository.save(dto.toEntity());
        return dto.getId();
    }

    // 하드 딜리트
    public void hardDelete(Long id) {
        inboundRepository.deleteById(id);
    }

    // 소프트 딜리트
    public void softDelete(InboundDeleteDto dto) {
        inboundRepository.save(dto.toEntity());
    }
}
