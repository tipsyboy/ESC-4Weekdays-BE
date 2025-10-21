package com.fourweekdays.fourweekdays.franchise.model.entity;

import com.fourweekdays.fourweekdays.common.vo.Address;
import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus;
import jakarta.persistence.*;

@Entity
public class FranchiseStore extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, length = 50, nullable = false)
    private String franchiseCode; // 공급업체 코드 (V-001, V-002 등)

    @Column(nullable = false, length = 200)
    private String name;

    @Column(length = 20)
    private String phoneNumber;

    @Column(length = 100)
    private String email;

    private String description; // 업체 설명 및 비고

    @Embedded
    private Address address;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private FranchiseStatus status; // (ACTIVE / INACTIVE)
}