package com.fourweekdays.fourweekdays.franchise.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.common.vo.Address;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
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

    // ===== 비즈니스 로직 ===== //
    public void update(String name, String phoneNumber, String email, String description, Address address, FranchiseStatus status) {
        if (name != null) this.name = name;
        if (phoneNumber != null) this.phoneNumber = phoneNumber;
        if (email != null) this.email = email;
        if (description != null) this.description = description;
        if (status != null) this.status = status;
        if (address != null) this.address = address;
    }
    public void suspended() {
        this.status = FranchiseStatus.SUSPENDED;
    }

    public boolean canOrder() {
        return this.status == FranchiseStatus.ACTIVE;
    }
}