package com.fourweekdays.fourweekdays.tasks.model.entity;

import lombok.Getter;

@Getter
public enum InboundWorkType {
    
    INSPECTION("검수"),
    PUT_AWAY("적치");

    private final String name;

    InboundWorkType(String name) {
        this.name = name;
    }
}
