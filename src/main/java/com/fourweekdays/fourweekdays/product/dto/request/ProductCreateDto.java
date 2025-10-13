package com.fourweekdays.fourweekdays.product.dto.request;

import com.fourweekdays.fourweekdays.product.model.Product;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProductCreateDto {

    private String productCode; // SKU/바코드
    private String productName; // 상품명
    private int costPrice;      // 매입가 (원가)
    private int listPrice;      // 소비자가 (리스트가)
    private int wholesalePrice; // 도매가 (가맹점 공급가)
    private int marginRate;     // 마진율 (%)
    private String currency; // 금액 단위 (KRW, USD, JPY 등)
    private String specification; // 규격 (예: 500ml, Box 20개입)
    private LocalDateTime expirationAt; // 유통기한
    private String originCountry; // 원산지

    //Entity 변환
    public Product toEntity() {
        return Product.builder()
                .productCode(this.productCode)
                .productName(this.productName)
                .costPrice(this.costPrice)
                .listPrice(this.listPrice)
                .wholesalePrice(this.wholesalePrice)
                .marginRate(this.marginRate)
                .currency(this.currency)
                .specification(this.specification)
                .expirationAt(this.expirationAt)
                .originCountry(this.originCountry)
                .build();
    }

}
