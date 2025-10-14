package com.fourweekdays.fourweekdays.purchaseorder.model.dto.response;

import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;

import java.time.LocalDate;

@AllArgsConstructor
@Builder
public class PurchaseOrderReadDto {

    private final Long id;

    private final String vendorName; // TODO: 공급 업체 연관관계 맞춘 후 변경

    //    private final Long quantity; // TODO: 상품 마다 발주 수량이 다른 경우 때문에 상품과 연관 관계 필요
    private final Long totalAmount; // 발주 금액

    private LocalDate issueDate;
    private LocalDate expectedDate;

    private PurchaseOrderStatus status;

    public static PurchaseOrderReadDto toDto(PurchaseOrder entity) {
        return PurchaseOrderReadDto.builder()
                .id(entity.getId())
                .totalAmount(entity.getTotalAmount())
                .issueDate(entity.getIssueDate())
                .expectedDate(entity.getExpectedDate())
                .status(entity.getStatus())
                .build();
    }
}
