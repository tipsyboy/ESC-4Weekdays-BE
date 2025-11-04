package com.fourweekdays.fourweekdays.outbound.model.entity;

public enum OutboundInventoryHistoryStatus {
    PENDING,    // 출고 기록 생성됨 (재고 차감 완료)
    COMPLETED,  // 정상 출고 완료
    CANCELLED   // 출고 취소로 인한 재고 복구됨
}
