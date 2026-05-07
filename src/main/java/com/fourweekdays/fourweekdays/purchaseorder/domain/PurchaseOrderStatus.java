package com.fourweekdays.fourweekdays.purchaseorder.domain;

import lombok.Getter;

@Getter
public enum PurchaseOrderStatus {

    DRAFT("작성중"),
    APPROVAL_PENDING("승인대기"),
    APPROVED("승인완료"),
    REJECTED("반려"),
    CANCELED("취소"),
    ORDERED("발주완료"),

    // 구 ASN/입고 코드 호환용 상태. 신규 발주 화면에서는 사용하지 않는다.
    REQUESTED("발주 요청"),
    AWAITING_DELIVERY("납품 대기"),
    COMPLETED("배송 완료"),
    CANCELLED("취소");

    private final String status;

    PurchaseOrderStatus(String description) {
        this.status = description;
    }

}
