package com.fourweekdays.fourweekdays.purchaseorder.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import jakarta.persistence.*;

@Entity
public class PurchaseOrderProduct extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    private PurchaseOrder purchaseOrder;

}

