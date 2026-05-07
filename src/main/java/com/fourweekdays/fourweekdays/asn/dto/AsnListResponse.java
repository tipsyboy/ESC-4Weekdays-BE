package com.fourweekdays.fourweekdays.asn.dto;

import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import java.time.LocalDateTime;

public record AsnListResponse(
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
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
    public static AsnListResponse from(Asn asn) {
        return new AsnListResponse(
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
                asn.getCreatedAt(),
                asn.getUpdatedAt()
        );
    }
}
