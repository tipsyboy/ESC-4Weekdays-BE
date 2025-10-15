package com.fourweekdays.fourweekdays.product.dto.request;


import com.fourweekdays.fourweekdays.product.model.ProductStatus;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
public class ProductUpdateDto {

    @NotBlank(message = "상품명은 필수입니다")
    @Size(max = 200, message = "상품명은 200자 이하로 입력해주세요")
    private String name;

    @Size(max = 50, message = "단위는 50자 이하로 입력해주세요")
    private String unit;

    @NotNull(message = "단가는 필수입니다")
    @Min(value = 0, message = "단가는 0원 이상이어야 합니다")
    private Long unitPrice;

    @Size(max = 1000, message = "설명은 1000자 이하로 입력해주세요")
    private String description;

    @NotNull(message = "상품 상태는 필수입니다")
    private ProductStatus status;

    @NotNull(message = "공급업체는 필수입니다")
    private Long vendorId; // 공급업체 변경 가능
}

