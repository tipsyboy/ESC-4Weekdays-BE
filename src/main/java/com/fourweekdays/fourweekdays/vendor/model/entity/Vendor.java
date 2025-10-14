package com.fourweekdays.fourweekdays.vendor.model.entity;

import com.fourweekdays.fourweekdays.common.Address;
import com.fourweekdays.fourweekdays.common.BaseEntity;
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
public class Vendor extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "vendor_id")
    private Long id;

    private String businessRegistrationNo; // 사업자 등록 번호

    private String name;
    private String phoneNumber;
    private String email;

    @Embedded
    private Address address;

}
