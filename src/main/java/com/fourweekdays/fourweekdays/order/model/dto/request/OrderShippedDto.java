package com.fourweekdays.fourweekdays.order.model.dto.request;

import com.fourweekdays.fourweekdays.product.model.entity.Product;
import lombok.Getter;

import java.util.List;

@Getter
public class OrderShippedDto {
    Long outboundId;
    List<Product> product; // 뭐 어떤 상품 받았는지 안해도 되고
    String receivedAt; // 수령 시간
}
