package com.fourweekdays.fourweekdays.outbound.service;

import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.order.exception.OrderException;
import com.fourweekdays.fourweekdays.order.model.entity.Order;
import com.fourweekdays.fourweekdays.order.repository.OrderRepository;
import com.fourweekdays.fourweekdays.outbound.exception.OutboundException;
import com.fourweekdays.fourweekdays.outbound.model.dto.request.OutboundCreateDto;
import com.fourweekdays.fourweekdays.outbound.model.dto.response.OutboundReadDto;
import com.fourweekdays.fourweekdays.outbound.model.dto.response.OutboundStatusResponse;
import com.fourweekdays.fourweekdays.outbound.model.entity.Outbound;
import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundStatus;
import com.fourweekdays.fourweekdays.outbound.repository.OutboundRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.order.exception.OrderExceptionType.ORDER_NOT_FOUND;

@Service
@RequiredArgsConstructor
@Transactional
public class OutboundService {

    private static final String OUTBOUND_CODE_PREFIX = "OB";

    private final MemberRepository memberRepository;
    private final OutboundRepository outboundRepository;
    private final CodeGenerator codeGenerator;
    private final OrderRepository orderRepository;

    // 출고 생성
    public Long createOutbound(OutboundCreateDto dto) {
        Member member = memberRepository.findById(dto.getMemberId())
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));

        Order order = orderRepository.findById(dto.getOrderId())
                .orElseThrow(() -> new OrderException(ORDER_NOT_FOUND));

        String OutboundCode = codeGenerator.generate(OUTBOUND_CODE_PREFIX);
        OutboundStatus status = OutboundStatus.PENDING;

        Outbound outbound = dto.toEntity(OutboundCode, status);

//        이러고 아웃바운드 product 만들기\


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
