package com.fourweekdays.fourweekdays.product.model.dto.request;

import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProductCreateDto {

    @NotBlank(message = "상품명은 필수입니다")
    @Size(max = 200, message = "상품명은 200자 이하로 입력해주세요")
    private String name;

    @NotBlank(message = "상품코드는 필수입니다")
    @Size(max = 50, message = "상품코드는 50자 이하로 입력해주세요")
    private String productCode;

    @Size(max = 50, message = "단위는 50자 이하로 입력해주세요")
    private String unit; // EA, Box, Kg 등

    @NotNull(message = "단가는 필수입니다")
    @Min(value = 0, message = "단가는 0원 이상이어야 합니다")
    private Long unitPrice;

    @Size(max = 1000, message = "설명은 1000자 이하로 입력해주세요")
    private String description;

    @NotNull(message = "상품 상태는 필수입니다")
    private ProductStatus status;
    private Long vendorId;

    // Entity 변환
    public Product toEntity() {
        return Product.builder()
                .name(this.name)
                .productCode(this.productCode)
                .unit(this.unit)
                .unitPrice(this.unitPrice)
                .description(this.description)
                .status(this.status)
                .build();
    }
}
