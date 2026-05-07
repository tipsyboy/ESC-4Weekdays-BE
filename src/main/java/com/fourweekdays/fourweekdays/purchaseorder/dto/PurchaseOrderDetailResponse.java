package com.fourweekdays.fourweekdays.purchaseorder.dto;

import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public record PurchaseOrderDetailResponse(
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
        List<PurchaseOrderItemResponse> items,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static PurchaseOrderDetailResponse from(PurchaseOrder purchaseOrder) {
        List<PurchaseOrderItemResponse> itemResponses = purchaseOrder.getItems().stream()
                .map(PurchaseOrderItemResponse::from)
                .toList();

        int totalQuantity = itemResponses.stream()
                .mapToInt(PurchaseOrderItemResponse::orderQuantity)
                .sum();

        long totalAmount = itemResponses.stream()
                .mapToLong(PurchaseOrderItemResponse::lineAmount)
                .sum();

        return new PurchaseOrderDetailResponse(
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
                itemResponses,
                purchaseOrder.getCreatedAt(),
                purchaseOrder.getUpdatedAt()
        );
    }
}
