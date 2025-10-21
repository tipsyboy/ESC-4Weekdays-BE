package com.fourweekdays.fourweekdays.purchaseorder.model.entity;

import lombok.Getter;

@Getter
public enum PurchaseOrderStatus {
//    DRAFT("임시저장"), // 작성중
    REQUESTED("발주 요청"), // 승인 대기
    APPROVED("승인 완료"), // 승인됨
//    ORDERED("발주완료"), // 공급업체에 발주함
//    PARTIALLY_RECEIVED("부분입고"),
    COMPLETED("완료"), // 입고 완료
    CANCELLED("취소"); // 취소됨

    private final String status;

    PurchaseOrderStatus(String description) {
        this.status = description;
    }

}
