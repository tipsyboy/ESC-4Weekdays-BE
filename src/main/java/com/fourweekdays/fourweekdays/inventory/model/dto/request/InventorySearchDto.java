package com.fourweekdays.fourweekdays.inventory.model.dto.request;

import lombok.Getter;

@Getter
public class InventorySearchDto {
    // 검색 조건

    // 상품 상세 조건들
    // 재고 번호
    private String productId;
    // 보관 위치
    private String location;
    // 수량
    private int quantity;
    // 작업자
    private String memberName;
    // 기간
    private Integer createAt;


//    입고/출고와 관계를 맺는다면
//    private Integer inboundAt;
//    private Integer outboundAt;
}
