package com.fourweekdays.fourweekdays.product.dto.response;

import com.fourweekdays.fourweekdays.product.model.Product;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDate;

@Getter
@Builder
public class ProductReadDto {

    private Long id;
    private String productCode;
    private String productName;
    private int costPrice;
    private int listPrice;
    private int wholesalePrice;
    private int marginRate;
    private String currency;
    private String specification;
    private LocalDate expirationAt;
    private String originCountry;

    public static ProductReadDto from(Product product) {
        return ProductReadDto.builder()
                .id(product.getId())
                .productCode(product.getProductCode())
                .productCode(product.getProductCode())
                .productName(product.getProductName())
                .costPrice(product.getCostPrice())
                .listPrice(product.getListPrice())
                .wholesalePrice(product.getWholesalePrice())
                .marginRate(product.getMarginRate())
                .currency(product.getCurrency())
                .specification(product.getSpecification())
                .expirationAt(LocalDate.from(product.getExpirationAt()))
                .originCountry(product.getOriginCountry())
                .build();
    }

}