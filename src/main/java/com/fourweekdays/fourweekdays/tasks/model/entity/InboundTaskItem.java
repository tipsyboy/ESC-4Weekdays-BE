package com.fourweekdays.fourweekdays.tasks.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Embeddable
@Getter @NoArgsConstructor
public class InboundTaskItem {

    @Column(name = "inbound_product_id", nullable = false)
    private Long inboundProductId;

    @Column(nullable = false)
    private Integer quantity; // 작업 대상 수량

    @Column(name = "inspected_quantity")
    private Integer inspectedQuantity; // 실제 검수 수량

    @Enumerated(EnumType.STRING)
    @Column(name = "inspection_result", length = 20)
    private InspectionResult inspectionResult; // PASS, FAIL, PARTIAL

    @Column(name = "inspection_note", length = 500)
    private String inspectionNote; // 검수 메모
}