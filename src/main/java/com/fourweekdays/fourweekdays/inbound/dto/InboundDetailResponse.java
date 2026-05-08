package com.fourweekdays.fourweekdays.inbound.dto;

import com.fourweekdays.fourweekdays.inbound.domain.Inbound;
import com.fourweekdays.fourweekdays.inbound.domain.InboundStatus;
import java.time.LocalDateTime;
import java.util.List;

public record InboundDetailResponse(
        Long id,
        String inboundNumber,
        Long purchaseOrderId,
        String purchaseOrderNumber,
        Long asnId,
        String asnNumber,
        Long vendorId,
        String vendorName,
        LocalDateTime expectedInboundAt,
        LocalDateTime receivedAt,
        InboundStatus status,
        String dock,
        String inboundMemo,
        String inspectionMemo,
        Integer expectedQuantity,
        Integer receivedQuantity,
        Integer defectQuantity,
        List<InboundItemResponse> items,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static InboundDetailResponse from(Inbound inbound) {
        List<InboundItemResponse> items = inbound.getItems().stream()
                .map(InboundItemResponse::from)
                .toList();

        int expectedQuantity = items.stream().mapToInt(InboundItemResponse::expectedQuantity).sum();
        int receivedQuantity = items.stream().mapToInt(InboundItemResponse::receivedQuantity).sum();
        int defectQuantity = items.stream().mapToInt(InboundItemResponse::defectQuantity).sum();

        return new InboundDetailResponse(
                inbound.getId(),
                inbound.getInboundNumber(),
                inbound.getPurchaseOrder() != null ? inbound.getPurchaseOrder().getId() : null,
                inbound.getPurchaseOrder() != null ? inbound.getPurchaseOrder().getPurchaseOrderNumber() : null,
                inbound.getAsn() != null ? inbound.getAsn().getId() : null,
                inbound.getAsn() != null ? inbound.getAsn().getAsnNumber() : null,
                inbound.getVendor() != null ? inbound.getVendor().getId() : null,
                inbound.getVendor() != null ? inbound.getVendor().getName() : null,
                inbound.getExpectedInboundAt(),
                inbound.getReceivedAt(),
                inbound.getStatus(),
                inbound.getDock(),
                inbound.getInboundMemo(),
                inbound.getInspectionMemo(),
                expectedQuantity,
                receivedQuantity,
                defectQuantity,
                items,
                inbound.getCreatedAt(),
                inbound.getUpdatedAt()
        );
    }
}
