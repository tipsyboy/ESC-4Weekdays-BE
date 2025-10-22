package com.fourweekdays.fourweekdays.warehouse.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.common.vo.Address;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Warehouse extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String phoneNumber;
    private String email;

    @Embedded
    private Address address;

//    @OneToMany
//    private List<Location> locations;

    public void update(String name, String phoneNumber, String email, Address address) {
        if (name != null) this.name = name;
        if (phoneNumber != null) this.phoneNumber = phoneNumber;
        if (email != null) this.email = email;
        if (address != null) this.address = address;
    }
}
