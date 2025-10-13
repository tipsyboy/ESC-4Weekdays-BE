package com.fourweekdays.fourweekdays.purchaseorder.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.vendor.Vendor;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class PurchaseOrder extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id")
    private Vendor vendor; // 공급 업체

    @OneToMany(mappedBy = "purchaseOrder", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<PurchaseOrderProduct> productList = new ArrayList<>();

    private int quantity; // 발주 수량
    private Long totalAmount; // 발주 금액

    private LocalDate issueDate; // 실제 발주 예정일
    private LocalDate expectedDate; // 입고 예정일

    @Enumerated(EnumType.STRING)
    private Status status;

}
