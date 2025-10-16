//package com.fourweekdays.fourweekdays.inbound.model.dto.response;
//
//import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
//import lombok.Builder;
//import lombok.Getter;
//
//@Getter
//@Builder
//public class InboundListDto {
//    //입고 ID
//    //사용자 ID
//    //발주 이름 or 발주 ID
//    //수량
//    //입고 상태
//    private Long inboundId;
////    private String memberName;
//    private Long memberId;
//    private Long purchaseOrderId;
//    private Long quantity;
//    private String inboundStatus;
//
//    public static InboundListDto from(Inbound entity) {
//        return InboundListDto.builder()
//                .inboundId(entity.getId())
//                .memberId(entity.getMember().getId())
//                .purchaseOrderId(entity.getPurchaseOrder().getId())
//                .quantity(entity.getQuantity())
//                .inboundStatus(entity.getStatus())
//                .build();
//    }
//}
