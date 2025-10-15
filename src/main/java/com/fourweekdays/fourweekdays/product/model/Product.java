package com.fourweekdays.fourweekdays.product.model;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Product extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 200)
    private String name;

    @Column(nullable = false, unique = true, length = 50)
    private String productCode;

    private Long unitPrice; // 단가

    @Column(length = 1000)
    private String description;

    private ProductStatus status;

//    @Column(nullable = false, unique = true, length = 50)
//    private String barcode; // 바코드 추후 구현

    // ===== 연관 관계 ===== //
    // ===== 로직 ===== //
}
