package com.fourweekdays.fourweekdays.inbound.model.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Builder
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class InboundCreateDto {

    private Long memberId;
    private Long purchaseOrderId;  // Optional: 발주서 기반 입고

    @Valid
    private List<InboundItemDto> items;  // Optional: 직접/추가 품목

    private LocalDateTime scheduledDate; // 입고 예상 시간
    private String description;



    @Getter
    @Builder
    @NoArgsConstructor(access = AccessLevel.PROTECTED)
    @AllArgsConstructor
    public static class InboundItemDto {

        @NotNull(message = "상품 ID는 필수입니다.")
        private Long productId;

        @NotNull(message = "수량이 없습니다.")
        @Min(value = 1, message = "품목은 1개 미만일 수 없습니다.")
        private Integer quantity; // 수량
    }
}