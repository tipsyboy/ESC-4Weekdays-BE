package com.fourweekdays.fourweekdays.inbound.model.dto.request;

import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.member.Member;
import com.fourweekdays.fourweekdays.purchaseorder.PurchaseOrder;
import lombok.Getter;

@Getter
public class InboundCreateDto {
    private Integer memberId;
    private Integer purchaseOrderId;
    private Integer quantity;

    public Inbound toEntity() {
        Member member = Member.builder().id(memberId).build();
        PurchaseOrder purchaseOrder = PurchaseOrder.builder().id(purchaseOrderId).build();

        return Inbound.builder()
                .member(member)
                .purchaseOrder(purchaseOrder)
                .quantity(Long.valueOf(this.quantity))
                .build();
    }
}