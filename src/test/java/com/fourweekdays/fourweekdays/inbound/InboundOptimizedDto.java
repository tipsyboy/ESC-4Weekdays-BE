package com.fourweekdays.fourweekdays.inbound;

import java.time.LocalDateTime;

public class InboundOptimizedDto {

    private Long inboundId;
    private String inboundCode;
    private String managerName;
    private String vendorName;
    private String purchaseOrderCode;
    private String productCode;
    private String productName;
    private Integer receivedQuantity;
    private LocalDateTime createdAt;

    public InboundOptimizedDto() {
    }

    public InboundOptimizedDto(Long inboundId, String inboundCode, String managerName,
                               String vendorName, String purchaseOrderCode, String productCode,
                               String productName, Integer receivedQuantity, LocalDateTime createdAt) {
        this.inboundId = inboundId;
        this.inboundCode = inboundCode;
        this.managerName = managerName;
        this.vendorName = vendorName;
        this.purchaseOrderCode = purchaseOrderCode;
        this.productCode = productCode;
        this.productName = productName;
        this.receivedQuantity = receivedQuantity;
        this.createdAt = createdAt;
    }

    public Long getInboundId() {
        return inboundId;
    }

    public String getInboundCode() {
        return inboundCode;
    }

    public String getManagerName() {
        return managerName;
    }

    public String getVendorName() {
        return vendorName;
    }

    public String getPurchaseOrderCode() {
        return purchaseOrderCode;
    }

    public String getProductCode() {
        return productCode;
    }

    public String getProductName() {
        return productName;
    }

    public Integer getReceivedQuantity() {
        return receivedQuantity;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
}
