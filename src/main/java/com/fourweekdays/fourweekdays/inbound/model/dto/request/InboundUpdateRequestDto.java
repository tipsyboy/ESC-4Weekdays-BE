package com.fourweekdays.fourweekdays.inbound.model.dto.request;

import jakarta.validation.Valid;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class InboundUpdateRequestDto {

    private Long memberId;

    @Valid
    private List<InboundItemDto> items;

    private LocalDateTime scheduledDate;
    private String description;
}
