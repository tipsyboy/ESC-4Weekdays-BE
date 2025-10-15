package com.fourweekdays.fourweekdays.inbound.model.dto.response;

import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class InboundReadDto {
    private Long inboundId;
    private Long memberId;
    private Long purchaseOrderId;
    private Long quantity;
    private String inboundStatus;
    private PurchaseOrderDetailDto purchaseOrderDetailDto;
    private ProductDetailDto productDetailDto;

    public static InboundReadDto from(Inbound entity) {
        // 이거를 도메인이 하게 만들겠다는 거잖아
        PurchaseOrderDetailDto purchaseOrderDto = PurchaseOrderDetailDto.from(entity.getPurchaseOrder());
        ProductDetailDto productDto = ProductDetailDto.from(entity.getPurchaseOrder().getProduct());
        return InboundReadDto.builder()
                .inboundId(entity.getId())
                .memberId(entity.getMember().getId())
                .quantity(entity.getQuantity())
                .inboundStatus(entity.getStatus())
                .purchaseOrderDetailDto(purchaseOrderDto)
                .productDetailDto(productDto)
                .build();
    }
}
