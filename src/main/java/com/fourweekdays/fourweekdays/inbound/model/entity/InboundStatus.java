package com.fourweekdays.fourweekdays.inbound.model.entity;


import lombok.Getter;

@Getter
public enum InboundStatus {

    SCHEDULED("입고예정"),
    RECEIVING("입고중"),
    COMPLETED("입고완료"),
    CANCELLED("취소");

    private final String description;

    InboundStatus(String description) {
        this.description = description;
    }
}