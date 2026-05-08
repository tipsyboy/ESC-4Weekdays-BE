package com.fourweekdays.fourweekdays.inbound.domain;

import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import jakarta.persistence.*;
import lombok.*;
import lombok.extern.slf4j.Slf4j;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Inbound extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String inboundCode;

    @Enumerated(EnumType.STRING)
    private InboundStatus status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member manager; // 입고 담당자

    private LocalDateTime scheduledDate; // 입고 예정 일시
    //    private LocalDateTime receivedDate; // 실제 입고(도착) 일시
//    private LocalDateTime startedDate; // 작업 시작 일시
//    private LocalDateTime completedDate; // 작업 완료 일시
//
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_id")
    private PurchaseOrder purchaseOrder;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "asn_id")
    private Asn asn;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id")
    private Vendor vendor;

    private LocalDateTime expectedInboundAt;
    private LocalDateTime receivedAt;

    @Column(length = 100)
    private String dock;

    @Column(length = 1000)
    private String inboundMemo;

    @Column(length = 1000)
    private String inspectionMemo;

    @Builder.Default
    @OneToMany(mappedBy = "inbound", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<InboundProduct> products = new ArrayList<>();

    private String description; // 비고

    // ===== ===== //
    public void updateData(Member manager, LocalDateTime scheduledDate, String description) {
        this.manager = manager;
        this.scheduledDate = scheduledDate;
        this.description = description;
    }

    public void updateItems(List<InboundProduct> newItems) {
        this.products.clear();
        this.products.addAll(newItems);
    }

    public void cancelInbound() {
        this.status = InboundStatus.CANCELLED;
    }

    public Optional<InboundProduct> findProductById(Long inboundProductId) {
        log.info("products={}", products);
        return products.stream()
                .filter(product -> product.getId().equals(inboundProductId))
                .findFirst();
    }

    public int getTotalReceivedQuantity() {
        return products.stream()
                .mapToInt(InboundProduct::getReceivedQuantity)
                .sum();
    }

    // ===== 입고 상태 변경 메서드 ===== //
    public void updateStatus(InboundStatus nextStatus) {
        log.info("next={}", nextStatus);
//        if (!this.status.canTransitionTo(nextStatus)) {
//            throw new InboundException(INBOUND_STATUS_TRANSITION_NOT_ALLOWED);
//        }
        this.status = nextStatus;
    }

    public Long getVendorId() {
        if (vendor != null) {
            return vendor.getId();
        }
        return this.purchaseOrder.getVendor().getId();
    }

    public String getInboundNumber() {
        return inboundCode;
    }

    public Vendor getVendor() {
        return vendor != null ? vendor : purchaseOrder.getVendor();
    }

    public LocalDateTime getExpectedInboundAt() {
        if (expectedInboundAt != null) {
            return expectedInboundAt;
        }
        if (scheduledDate != null) {
            return scheduledDate;
        }
        return purchaseOrder != null && purchaseOrder.getExpectedInboundDate() != null
                ? purchaseOrder.getExpectedInboundDate().atTime(9, 0)
                : null;
    }

    public String getInboundMemo() {
        return inboundMemo != null ? inboundMemo : description;
    }

    public List<InboundProduct> getItems() {
        return products;
    }

    public void addItem(InboundProduct item) {
        item.assignInbound(this);
    }

    public void updateProcessing(LocalDateTime receivedAt, InboundStatus status, String inspectionMemo) {
        this.receivedAt = receivedAt;
        this.status = status;
        this.inspectionMemo = inspectionMemo;
    }
}
