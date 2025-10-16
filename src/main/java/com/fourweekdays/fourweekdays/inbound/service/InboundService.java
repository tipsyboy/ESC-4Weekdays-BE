package com.fourweekdays.fourweekdays.inbound.service;

import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundCreateRequestDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundUpdateRequestDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.response.InboundReadDto;
import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.inbound.model.entity.InboundProductItem;
import com.fourweekdays.fourweekdays.inbound.model.entity.InboundStatus;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
@RequiredArgsConstructor
public class InboundService {

    private final MemberRepository memberRepository;
    private final InboundRepository inboundRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;

    public Long create(InboundCreateRequestDto dto) {
        Member manager = memberRepository.findById(dto.getMemberId())
                .orElseThrow(() -> new IllegalArgumentException("해당 직원을 찾을 수 없습니다."));

        PurchaseOrder purchaseOrder = purchaseOrderRepository.findById(dto.getPurchaseOrderId())
                .orElseThrow(() -> new IllegalArgumentException("해당 발주서를 찾을 수 없습니다."));

        Inbound inbound = Inbound.builder()
                .scheduledDate(dto.getScheduledDate())
                .status(InboundStatus.SCHEDULED)
                .inboundNumber(generateInboundNumber())
                .description(dto.getDescription())
                .purchaseOrder(purchaseOrder)
                .managerName(manager.getName())
                .items(null)
                .build();
        return inboundRepository.save(inbound).getId();
    }

//    public List<InboundListDto> list(Integer page, Integer size) {
//        // TODO: dto 변경에 따른 로직 변경
//        Page<Inbound> result = inboundRepository.findAll(PageRequest.of(page, size));
//        return result.stream().map(InboundListDto::from).toList();
//    }

    public InboundReadDto detail(Long id) {
        Inbound entity = inboundRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("inbound를 찾을 수 없습니다."));
        return InboundReadDto.from(entity);
    }

    public Long update(InboundUpdateRequestDto dto) {
        return null;
    }

    // 소프트 딜리트
    public void softDelete(Long id) {
    }

//    // 하드 딜리트
//    public void hardDelete(Long id) {
//        inboundRepository.deleteById(id);
//    }


    private String generateInboundNumber() {
        // TODO: 실제 구현 필요
        // IB-20251016-001 형식으로 생성
        return "IB-" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")) + "-001";
    }
}
