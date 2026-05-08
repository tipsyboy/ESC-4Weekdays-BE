package com.fourweekdays.fourweekdays.inbound.dto;

import com.fourweekdays.fourweekdays.inbound.domain.Inbound;
import com.fourweekdays.fourweekdays.inbound.domain.InboundProduct;
import com.fourweekdays.fourweekdays.inbound.domain.InboundStatus;
import java.time.LocalDateTime;

public record InboundListResponse(
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
        Integer expectedQuantity,
        Integer receivedQuantity,
        Integer defectQuantity,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static InboundListResponse from(Inbound inbound) {
        int expectedQuantity = inbound.getItems().stream().mapToInt(InboundProduct::getExpectedQuantity).sum();
        int receivedQuantity = inbound.getItems().stream().mapToInt(InboundProduct::getReceivedQuantity).sum();
        int defectQuantity = inbound.getItems().stream().mapToInt(InboundProduct::getDefectQuantity).sum();

        return new InboundListResponse(
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
                expectedQuantity,
                receivedQuantity,
                defectQuantity,
                inbound.getCreatedAt(),
                inbound.getUpdatedAt()
        );
    }
}
