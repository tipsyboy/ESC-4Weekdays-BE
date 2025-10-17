package com.fourweekdays.fourweekdays.inventory.model.dto.request;

import lombok.Getter;

@Getter
public class InventorySearchDto {
    //    private Product product; // 상품 상세 조건들
    private String inventoryId;; // 재고 번호
    private String location; // 보관 위치
    private int quantity; // 수량
    private String memberName; // 작업자
    private Integer createAt; // 기간

//    입고/출고와 관계를 맺는다면
//    private Integer inboundAt;
//    private Integer outboundAt;
}
