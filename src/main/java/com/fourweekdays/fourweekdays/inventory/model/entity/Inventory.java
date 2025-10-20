package com.fourweekdays.fourweekdays.inventory.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import jakarta.persistence.*;

@Entity
public class Inventory extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product; // 어떤 상품인지

    private int quantity;  // 재고 수량
    private String location; // 보관 위치 (선반, 랙 등 예: A12309 구역)

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member; // 적치 작업자가 누구인지

// 입고/출고를 관계맺어 사용하게 된다면 Member를 지우고 입고/출고에 할당되어 있는 작업자를 조회

//    @ManyToOne
//    @JoinColumn(name = "inbound_id")
//    private Inbound inbound;
//    입고가 언제 되었는지 어떤 입고 작업이었는지 기록하면 좋을 것 같음

//    @ManyToOne
//    @JoinColumn(name = "outbound_id")
//    private Outbound outbound;
//    출고는 재고 기록용으로

//    @ManyToOne
//    @JoinColumn(name = "warehouse_id")
//    private Warehouse warehouse;
}
