package com.fourweekdays.fourweekdays.outbound.model.dto.request;

import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.order.model.entity.Order;
import com.fourweekdays.fourweekdays.outbound.model.entity.Outbound;
import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundStatus;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
@Builder
public class OutboundCreateDto {

    private Long orderId;
    private LocalDateTime scheduledDate; // 출고 예상 시간
    private String description;
//     private List<InboundProductDto> items; // 직접/추가

    public Outbound toEntity(String outboundCode, OutboundStatus status, Member manager) {
        return Outbound.builder()
                .outboundManager(manager)
                .order(Order.builder().orderId(orderId).build())
                .scheduledDate(scheduledDate)
                .description(description)
                .outboundCode(outboundCode)
                .status(status)
                .build();
    }
}

