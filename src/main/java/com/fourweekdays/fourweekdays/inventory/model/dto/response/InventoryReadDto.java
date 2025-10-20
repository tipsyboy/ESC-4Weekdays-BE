package com.fourweekdays.fourweekdays.inventory.model.dto.response;

import com.fourweekdays.fourweekdays.product.model.entity.Product;
import lombok.*;

@Getter
public class InventoryReadDto { // 상세 조회
    private String inventoryId;
    private Product product; // 상품 코드, 상품명, 재고 단위, 단가
    private String location;
    private int quantity;

}
