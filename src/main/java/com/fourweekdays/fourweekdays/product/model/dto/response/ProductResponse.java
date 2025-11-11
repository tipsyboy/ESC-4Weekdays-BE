package com.fourweekdays.fourweekdays.product.model.dto.response;

import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class ProductResponse {

    private String name;
    private String productCode;
    private String unit; // 단위 (예: EA, Box ...)
    private Long unitPrice; // 단가
    private ProductStatus status; //ACTIVE, INACTIVE, DISCONTINUED

    public static ProductResponse from(Product product) {
        return ProductResponse.builder()
                .name(product.getName())
                .productCode(product.getProductCode())
                .unit(product.getUnit())
                .unitPrice(product.getUnitPrice())
                .status(product.getStatus())
                .build();
    }
}
