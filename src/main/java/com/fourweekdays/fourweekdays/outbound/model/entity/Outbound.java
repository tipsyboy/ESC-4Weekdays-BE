package com.fourweekdays.fourweekdays.outbound.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.order.Order;
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
@Table(name = "outbound")
public class Outbound extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "outbound_id")
    private Long id; // 출고 ID

    @Enumerated(EnumType.STRING)
    private OutboundType outboundType; // 출고유형

    @Enumerated(EnumType.STRING)
    private OutboundStatus status; // 출고상태

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member; // 출고 등록인
    // 출고에 맴버에 대한 연관 관계는 이렇게 생각함 이 문서를 생성한 인원이라고 생각하고 null 허용
    // 작업 부분에서 출고 상세 작업들에 대해 알아서 인원 배정할 것이고

//    @OneToMany(fetch = FetchType.LAZY)
//    private List<OutboundProductItem> items = new ArrayList<>();
//
//    @ManyToOne
//    @JoinColumn(name = "franchise_store_id")
//    private FranchiseStore store;
//
}