package com.fourweekdays.fourweekdays.purchaseorder.model.entity;

import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PurchaseOrder extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String orderCode;

    @Column(unique = true, length = 50)
    private String purchaseOrderNumber;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id", nullable = false)
    private Vendor vendor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member manager; // 발주 담당자. old Inbound 연동 호환용이며 추후 requester/approver 구조로 정리한다.

    @Builder.Default
    @OneToMany(mappedBy = "purchaseOrder", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PurchaseOrderProduct> products = new ArrayList<>();

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private PurchaseOrderStatus status;

    @Column(length = 100)
    private String requesterName; // 발주 요청자

    @Column(length = 100)
    private String approverName; // 발주 승인자

    private LocalDateTime requestedAt;

    private LocalDateTime approvedAt;
    private LocalDateTime orderedAt;
    private LocalDate expectedInboundDate;

    @Column(length = 1000)
    private String requestMemo;

    @Column(length = 1000)
    private String approvalMemo;

    @Column(length = 1000)
    private String description;

    private LocalDateTime orderDate; // 발주일
    private LocalDateTime expectedDate; // 입고 예정일
    private Long totalAmount;
    private String rejectedReason;
    private LocalDateTime rejectedAt;


    // ===== 연관관계 편의 메서드 ===== //
    public void addItem(PurchaseOrderProduct purchaseOrderProduct) {
        purchaseOrderProduct.mappingPurchaseOrder(this);
    }

    // ===== 비즈니스 로직 ===== //
    public void update(LocalDateTime expectedDate, String description) {
        if (expectedDate != null) this.expectedDate = expectedDate;
        if (description != null) this.description = description;
    }

    public void rejectByVendor(String reason) {
        this.rejectedReason = reason;
        this.rejectedAt = LocalDateTime.now();
        this.status = PurchaseOrderStatus.CANCELLED;
    }

    public Long calculateTotalAmount() {
        Long totalAmount = products.stream()
                .mapToLong(PurchaseOrderProduct::calculateAmount)
                .sum();
        this.totalAmount = totalAmount;
        return totalAmount;
    }

    private void recalculateTotalAmount() {
        this.totalAmount = calculateTotalAmount();
    }

    public void removeItem(PurchaseOrderProduct item) {
        this.products.remove(item);
        recalculateTotalAmount();
    }

    public void clearItems() {
        this.products.clear();
        this.totalAmount = 0L;
    }

    // ===== 상태 관리 메서드 ===== //
    public void approve() {
        this.status = PurchaseOrderStatus.APPROVED;
    }

    public void approve(String approverName, String approvalMemo, LocalDateTime approvedAt) {
        this.status = PurchaseOrderStatus.APPROVED;
        this.approverName = approverName;
        this.approvalMemo = approvalMemo;
        this.approvedAt = approvedAt;
    }

    public void reject(String approvalMemo) {
        this.status = PurchaseOrderStatus.REJECTED;
        this.approvalMemo = approvalMemo;
    }

    public void markOrdered(LocalDateTime orderedAt) {
        this.status = PurchaseOrderStatus.ORDERED;
        this.orderedAt = orderedAt;
    }

    public void changeStatus(PurchaseOrderStatus status) {
        this.status = status;
    }

    // 발주 확정 (공급사 납품 준비 완료)
    public void awaitDelivery() {
        this.status = PurchaseOrderStatus.AWAITING_DELIVERY;
    }

    // 입고 완료 처리 (ASN → 입고 완료 시점)
    public void completeDelivery() {
        this.status = PurchaseOrderStatus.COMPLETED;
    }

    // 발주 취소
    public void cancel() {
        this.status = PurchaseOrderStatus.CANCELLED;
    }

    public void cancelVibe() {
        this.status = PurchaseOrderStatus.CANCELED;
    }

    // 상품 제거
    public void deleteItem(PurchaseOrderProduct item) {
        if (this.products.remove(item)) {
            recalculateTotalAmount();
        }
    }

    public String getPurchaseOrderNumber() {
        return purchaseOrderNumber != null ? purchaseOrderNumber : orderCode;
    }

    public LocalDateTime getRequestedAt() {
        return requestedAt != null ? requestedAt : orderDate;
    }

    public LocalDate getExpectedInboundDate() {
        if (expectedInboundDate != null) {
            return expectedInboundDate;
        }
        return expectedDate != null ? expectedDate.toLocalDate() : null;
    }

    public String getRequesterName() {
        if (requesterName != null) {
            return requesterName;
        }
        return manager != null ? manager.getName() : "운영관리자";
    }

    public String getRequestMemo() {
        return requestMemo != null ? requestMemo : description;
    }

    public List<PurchaseOrderProduct> getItems() {
        return products;
    }
}
