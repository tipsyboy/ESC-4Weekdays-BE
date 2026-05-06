package com.fourweekdays.fourweekdays.purchaseorder.dto;

import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import java.time.LocalDate;
import java.time.LocalDateTime;

public record PurchaseOrderListResponse(
        Long id,
        String purchaseOrderNumber,
        Long vendorId,
        String vendorName,
        String requesterName,
        String approverName,
        LocalDateTime requestedAt,
        LocalDateTime approvedAt,
        LocalDateTime orderedAt,
        LocalDate expectedInboundDate,
        PurchaseOrderStatus status,
        String requestMemo,
        String approvalMemo,
        Integer totalQuantity,
        Long totalAmount,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static PurchaseOrderListResponse from(PurchaseOrder purchaseOrder) {
        int totalQuantity = purchaseOrder.getItems().stream()
                .mapToInt(item -> item.getOrderQuantity())
                .sum();

        long totalAmount = purchaseOrder.getItems().stream()
                .mapToLong(item -> (long) item.getOrderQuantity() * item.getOrderUnitPrice())
                .sum();

        return new PurchaseOrderListResponse(
                purchaseOrder.getId(),
                purchaseOrder.getPurchaseOrderNumber(),
                purchaseOrder.getVendor().getId(),
                purchaseOrder.getVendor().getName(),
                purchaseOrder.getRequesterName(),
                purchaseOrder.getApproverName(),
                purchaseOrder.getRequestedAt(),
                purchaseOrder.getApprovedAt(),
                purchaseOrder.getOrderedAt(),
                purchaseOrder.getExpectedInboundDate(),
                purchaseOrder.getStatus(),
                purchaseOrder.getRequestMemo(),
                purchaseOrder.getApprovalMemo(),
                totalQuantity,
                totalAmount,
                purchaseOrder.getCreatedAt(),
                purchaseOrder.getUpdatedAt()
        );
    }
}
