package com.fourweekdays.fourweekdays.member.domain;

import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.tasks.model.entity.Task;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Member extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 직원/사용자 ID (PK)

    @Column(unique = true, length = 50)
    private String memberCode;

    @Column(unique = true, length = 100)
    private String loginId;

    private String email;
    private String password;
    private String name;
    private String department;
    private String phoneNumber;
    private LocalDateTime joinAt;  // 입사일 or 창고 전입일

    @Enumerated(EnumType.STRING)
    private MemberRole role; // 직급 / 역할

    @Enumerated(EnumType.STRING)
    private MemberStatus status; // 계정 상태 (ACTIVE=활성, INACTIVE=비활성, LOCK=잠금)

    @Column(length = 1000)
    private String note;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id")
    private Vendor vendor;

    @OneToMany(mappedBy = "worker", fetch = FetchType.LAZY) //
    private List<Task> taskList;

    @OneToMany(mappedBy = "manager", fetch = FetchType.LAZY)
    private List<PurchaseOrder> purchaseOrders;

    // ===== 로직 ===== //
    public void update(
            String name,
            String department,
            String email,
            String phoneNumber,
            String password,
            MemberRole role,
            MemberStatus status,
            String note,
            Vendor vendor
    ) {
        if (name != null)this.name = name;
        if (department != null)this.department = department;
        if (email != null)this.email = email;
        if (password != null)this.password = password;
        if (phoneNumber != null)this.phoneNumber = phoneNumber;
        if (role != null)this.role = role;
        if (status != null)this.status = status;
        if (note != null)this.note = note;
        this.vendor = vendor;
    }
}
