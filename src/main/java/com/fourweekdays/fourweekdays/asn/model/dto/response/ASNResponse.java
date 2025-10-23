package com.fourweekdays.fourweekdays.asn.model.dto.response;

import com.fourweekdays.fourweekdays.asn.model.entity.ASN;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderProductResponseDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import lombok.Builder;

import java.time.LocalDateTime;
import java.util.List;

@Builder
public class ASNResponse {

    private Long id;
    private String asnCode;
    private String vendorName;
    private LocalDateTime expectedDate;
    private String description; // 비고

    private List<PurchaseOrderProductResponseDto> products;

    public static ASNResponse toDto(ASN asn) {
        PurchaseOrder purchaseOrder = asn.getPurchaseOrder();

        return ASNResponse.builder()
                .id(asn.getId())
                .asnCode(asn.getAsnCode())
                .vendorName(asn.getVendor().getName())
                .expectedDate(asn.getExpectedDate())
                .description(asn.getDescription())
                .products(purchaseOrder.getItems().stream()
                        .map(PurchaseOrderProductResponseDto::toDto)
                        .toList())
                .build();
    }
}
