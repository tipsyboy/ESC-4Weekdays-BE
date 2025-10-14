package com.fourweekdays.fourweekdays.Inbound.model.dto.request;

import com.fourweekdays.fourweekdays.Inbound.model.entity.Inbound;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class InboundDeleteDto {
    private Long id;

    public Inbound toEntity() {
        return Inbound.builder()
                .id(this.id)
                .deleted("deleted")
                .build();
    }
}
