package com.fourweekdays.fourweekdays.inbound.domain;


import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
public enum InboundStatus {

    PLANNED("입고 예정"),
    RECEIVING("입고중"),
    PARTIAL("부분 입고"),
    COMPLETED("입고 완료"),
    CANCELLED("취소"),

    // Legacy Task 기반 입고 흐름 상태. 현재 Inbound 활성 API에서는 사용하지 않는다.
    CREATED("입고서 생성"), // 발주 or 입고지시 생성 상태
    SCHEDULED("입고 예정"), // 실제 도착 일정이 잡힘
    ARRIVED("도착"), // 차량 도착 or ASN 접수 완료
    INSPECTING("검수중"), // 수량/품질 검수 단계
    PUTAWAY("적치중"); // 창고 위치로 이동 중

    private final String description;

    InboundStatus(String description) {
        this.description = description;
    }

    public boolean canTransitionTo(InboundStatus next) {
        return switch (this) {
            case PLANNED -> next == RECEIVING || next == PARTIAL || next == COMPLETED || next == CANCELLED;
            case RECEIVING -> next == PARTIAL || next == COMPLETED || next == CANCELLED;
            case PARTIAL -> next == RECEIVING || next == COMPLETED || next == CANCELLED;
            default -> false; // COMPLETED, CANCELLED 변경 불가
        };
    }
}
