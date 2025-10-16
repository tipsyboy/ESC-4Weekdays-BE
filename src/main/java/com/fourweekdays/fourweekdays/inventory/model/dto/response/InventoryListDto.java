package com.fourweekdays.fourweekdays.inventory.model.dto.response;

import lombok.*;

@Getter
public class InventoryListDto {
    private String inventoryId;
    private String productId; // 상품 코드, 상품명
    private int quantity;
    private String location;
}
