package com.fourweekdays.fourweekdays.product.model;

public enum ProductStatus {
    RECEIVED("입고"),
    INSPECTING("검수중"),
    INSPECTED("검수 완료"),
    STORING("적치중"),
    APPROVED("승인");

    private final String label;

    ProductStatus(String label){
        this.label = label;
    }

}
