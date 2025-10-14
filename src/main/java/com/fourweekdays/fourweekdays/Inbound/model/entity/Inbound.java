package com.fourweekdays.fourweekdays.Inbound.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.member.Member;
import com.fourweekdays.fourweekdays.purchaseorder.PurchaseOrder;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Inbound extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long quantity; // 입고 수량

    @Enumerated(EnumType.STRING)
    private InboundStatus status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "purchaseOrder_id")
    private PurchaseOrder purchaseOrder;
}
