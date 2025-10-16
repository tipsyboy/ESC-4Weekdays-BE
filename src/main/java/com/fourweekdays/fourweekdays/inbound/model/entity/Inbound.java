package com.fourweekdays.fourweekdays.inbound.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Inbound extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String inboundNumber;

    @Enumerated(EnumType.STRING)
    private InboundStatus status;

    // TODO: Member와 연관관계
    private String managerName; // 입고 담당자
    private String workerName; // 작업 담당자

    private LocalDateTime scheduledDate; // 입고 예정 일시
//    private LocalDateTime receivedDate; // 실제 입고(도착) 일시
//    private LocalDateTime startedDate; // 작업 시작 일시
//    private LocalDateTime completedDate; // 작업 완료 일시
//
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchase_order_id")
    private PurchaseOrder purchaseOrder;

    @OneToMany(mappedBy = "inbound")
    private List<InboundProductItem> items = new ArrayList<>();

    private String description; // 비고

    public void updatePurchaseOrder(PurchaseOrder purchaseOrder) {
        this.purchaseOrder = purchaseOrder;
    }

//    private String invoiceNumber; // 송장 번호
//    private String receivedBy; // 입고 담당자
//    private String driverName; // 배달 기사
//    private String driverPhoneNumber;

}
