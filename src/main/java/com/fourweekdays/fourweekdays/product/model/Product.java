package com.fourweekdays.fourweekdays.product.model;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
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
    @Column(name = "product_id")
    private Long id;

    @Column(nullable = false, length = 200)
    private String name;

    @Column(nullable = false, unique = true, length = 50)
    private String productCode;

    @Column(length = 50)
    private String unit; // 단위 (예: EA, Box ...)

    private Long unitPrice; // 단가

    @Column(length = 1000)
    private String description;

    @Enumerated(EnumType.STRING)
    private ProductStatus status; //ACTIVE, INACTIVE, DISCONTINUED

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vendor_id")
    private Vendor vendor; // 공급업체

//    @Column(nullable = false, unique = true, length = 50)
//    private String barcode; // 바코드 추후 구현

    // ===== 연관 관계 ===== //
    // ===== 로직 ===== //
}
