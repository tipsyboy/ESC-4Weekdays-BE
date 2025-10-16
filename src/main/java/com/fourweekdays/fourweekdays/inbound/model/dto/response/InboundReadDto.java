package com.fourweekdays.fourweekdays.inbound.model.dto.response;

import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.inbound.model.entity.InboundStatus;
import lombok.*;

import java.util.List;

@Getter
@Builder
@AllArgsConstructor
public class InboundReadDto {

    private final Long inboundId;
    private final Long purchaseOrderId;
    private final Long memberId; // 담당자
    private final InboundStatus status;
    private List<InboundProductItemResponseDto> items;

}
