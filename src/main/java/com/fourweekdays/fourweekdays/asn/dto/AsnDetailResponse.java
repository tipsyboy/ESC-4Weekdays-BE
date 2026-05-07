package com.fourweekdays.fourweekdays.asn.dto;

import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import java.time.LocalDateTime;
import java.util.List;

public record AsnDetailResponse(
        Long id,
        Long purchaseOrderId,
        String purchaseOrderNumber,
        String asnNumber,
        Long vendorId,
        String vendorName,
        String vendorManagerName,
        String vendorPhoneNumber,
        LocalDateTime expectedArrivalAt,
        LocalDateTime receivedAt,
        AsnStatus status,
        String vehicleInfo,
        String contactName,
        String contactPhoneNumber,
        String note,
        List<AsnItemResponse> items,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static AsnDetailResponse from(Asn asn) {
        return new AsnDetailResponse(
                asn.getId(),
                asn.getPurchaseOrder().getId(),
                asn.getPurchaseOrder().getPurchaseOrderNumber(),
                asn.getAsnNumber(),
                asn.getPurchaseOrder().getVendor().getId(),
                asn.getPurchaseOrder().getVendor().getName(),
                asn.getPurchaseOrder().getVendor().getManagerName(),
                asn.getPurchaseOrder().getVendor().getPhoneNumber(),
                asn.getExpectedArrivalAt(),
                asn.getReceivedAt(),
                asn.getStatus(),
                asn.getVehicleInfo(),
                asn.getContactName(),
                asn.getContactPhoneNumber(),
                asn.getNote(),
                asn.getItems().stream().map(AsnItemResponse::from).toList(),
                asn.getCreatedAt(),
                asn.getUpdatedAt()
        );
    }
}
