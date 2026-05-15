package com.fourweekdays.fourweekdays.vendor.dto;

import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus;
import java.time.LocalDate;
import java.time.LocalDateTime;

public record VendorPurchaseOrderListResponse(
        Long id,
        String purchaseOrderNumber,
        Long vendorId,
        String vendorName,
        String requesterName,
        LocalDateTime orderedAt,
        LocalDate expectedInboundDate,
        PurchaseOrderStatus status,
        String requestMemo,
        Integer itemCount,
        Integer totalQuantity,
        Long totalAmount,
        Long asnId,
        String asnNumber,
        AsnStatus asnStatus,
        LocalDateTime asnExpectedArrivalAt,
        String vehicleInfo,
        String contactName,
        Integer announcedItemCount,
        Integer announcedTotalQuantity,
        String replyStatus,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static VendorPurchaseOrderListResponse from(PurchaseOrder purchaseOrder, Asn asn) {
        int itemCount = purchaseOrder.getItems().size();
        int totalQuantity = purchaseOrder.getItems().stream()
                .mapToInt(item -> item.getOrderQuantity())
                .sum();
        long totalAmount = purchaseOrder.getItems().stream()
                .mapToLong(item -> (long) item.getOrderQuantity() * item.getOrderUnitPrice())
                .sum();

        int announcedItemCount = asn == null ? 0 : asn.getItems().size();
        int announcedTotalQuantity = asn == null ? 0 : asn.getItems().stream()
                .mapToInt(item -> item.getAnnouncedQuantity())
                .sum();

        String replyStatus = asn == null
                ? "NONE"
                : asn.getStatus() == AsnStatus.REJECTED ? "REJECTED" : "DONE";

        return new VendorPurchaseOrderListResponse(
                purchaseOrder.getId(),
                purchaseOrder.getPurchaseOrderNumber(),
                purchaseOrder.getVendor().getId(),
                purchaseOrder.getVendor().getName(),
                purchaseOrder.getRequesterName(),
                purchaseOrder.getOrderedAt(),
                purchaseOrder.getExpectedInboundDate(),
                purchaseOrder.getStatus(),
                purchaseOrder.getRequestMemo(),
                itemCount,
                totalQuantity,
                totalAmount,
                asn == null ? null : asn.getId(),
                asn == null ? null : asn.getAsnNumber(),
                asn == null ? null : asn.getStatus(),
                asn == null ? null : asn.getExpectedArrivalAt(),
                asn == null ? null : asn.getVehicleInfo(),
                asn == null ? null : asn.getContactName(),
                announcedItemCount,
                announcedTotalQuantity,
                replyStatus,
                purchaseOrder.getCreatedAt(),
                purchaseOrder.getUpdatedAt()
        );
    }
}
