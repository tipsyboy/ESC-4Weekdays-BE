package com.fourweekdays.fourweekdays.product.model;

// 시스템에 필요한 워크플로우 상수로 별도 테이블X
public enum ProductStatus {
    RECEIVED("입고"),
    INSPECTING("검수중"),
    INSPECTED("검수 완료"),
    STORING("적치중"),
    APPROVED("승인");

    private final String label;

    ProductStatus(String label) {
        this.label = label;
    }

}
