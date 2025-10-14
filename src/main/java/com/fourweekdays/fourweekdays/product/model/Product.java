package com.fourweekdays.fourweekdays.product.model;

import com.fourweekdays.fourweekdays.category.model.Category;
import com.fourweekdays.fourweekdays.common.BaseEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Product extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // 상품 ID

    private String productCode; // SKU/바코드
    private String productName; // 상품명
    private int costPrice;      // 매입가 (원가)
    private int listPrice;      // 소비자가 (리스트가)
    private int wholesalePrice; // 도매가 (가맹점 공급가)
    private int marginRate;     // 마진율 (%)
    private String currency; // 금액 단위 (KRW, USD, JPY 등)
    private String specification; // 규격 (예: 500ml, Box 20개입)
    private LocalDate expirationAt; // 유통기한
    private String originCountry; // 원산지

    @Enumerated(EnumType.STRING)
    private ProductStatus status;   // 현재 상품 상태

    public void updateStatus(ProductStatus newStatus){
        this.status = newStatus;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category; // 상품 카테고리
//
//    @ManyToOne
//    @JoinColumn(name = "partner_id")
//    private Vendor vendor;   // 공급업체 (Vendor)
}
