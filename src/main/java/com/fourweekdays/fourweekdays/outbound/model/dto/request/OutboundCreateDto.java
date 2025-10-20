package com.fourweekdays.fourweekdays.outbound.model.dto.request;

import com.fourweekdays.fourweekdays.outbound.model.entity.Outbound;
import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundStatus;
import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundType;
import lombok.Getter;

@Getter
public class OutboundCreateDto {
    private int quantity;
    private OutboundType outboundType;

    public Outbound toEntity() {
        return Outbound.builder()
//                .quantity(quantity)
                .outboundType(outboundType)
                .status(OutboundStatus.PENDING)
                .build();
    }
}

