package com.fourweekdays.fourweekdays.asn.service;

import com.fourweekdays.fourweekdays.asn.exception.AsnException;
import com.fourweekdays.fourweekdays.asn.dto.AsnReceiveRequest;
import com.fourweekdays.fourweekdays.asn.dto.PurchaseOrderRejectRequest;
import com.fourweekdays.fourweekdays.asn.dto.AsnReceiveResponse;
import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import com.fourweekdays.fourweekdays.asn.repository.AsnRepository;
import com.fourweekdays.fourweekdays.global.util.CodeGenerator;
import com.fourweekdays.fourweekdays.global.util.CodeType;
import com.fourweekdays.fourweekdays.inbound.service.InboundService;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.asn.exception.AsnExceptionType.ASN_ALREADY_EXISTS;
import static com.fourweekdays.fourweekdays.asn.exception.AsnExceptionType.VENDOR_MISMATCH;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.*;
import static com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus.APPROVED;

@Transactional(readOnly = true)
@RequiredArgsConstructor
@Service
public class AsnVendorService {

    private final AsnRepository asnRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final InboundService inboundService;
    private final CodeGenerator codeGenerator;

    @Transactional
    public AsnReceiveResponse receiveAsn(Vendor vendor, AsnReceiveRequest request) {
        PurchaseOrder purchaseOrder = findAndValidatePurchaseOrder(vendor, request.orderCode());

        if (purchaseOrder.getStatus() != APPROVED) {
            throw new PurchaseOrderException(PURCHASE_ORDER_INVALID_STATUS_FOR_ASN);
        }

        if (asnRepository.existsByPurchaseOrder(purchaseOrder)) {
            throw new AsnException(ASN_ALREADY_EXISTS);
        }

        Asn asn = Asn.create(
                vendor,
                purchaseOrder,
                codeGenerator.generate(CodeType.ASN),
                request.expectedDate(),
                request.description(),
                AsnStatus.ACCEPTED
        );
        asnRepository.save(asn);

        // inbound 자동 생성
        purchaseOrder.awaitDelivery(); // 배송대기 상태로 변경
        inboundService.createByPurchaseOrder(purchaseOrder); // 발주서에 따른 입고서 생성

        return AsnReceiveResponse.builder()
                .asnCode(asn.getAsnCode())
                .message("ASN이 성공적으로 등록되었습니다")
                .build();
    }

    @Transactional
    public void rejectPurchaseOrderByVendor(Vendor vendor, PurchaseOrderRejectRequest request) {
        PurchaseOrder purchaseOrder = findAndValidatePurchaseOrder(vendor, request.orderCode());

        if (purchaseOrder.getStatus() != APPROVED) {
            throw new PurchaseOrderException(PURCHASE_ORDER_CANNOT_REJECT);
        }

        purchaseOrder.rejectByVendor(request.description());

        // reject된 발주건 테이블 저장
        Asn rejectedAsn = Asn.create(
                vendor,
                purchaseOrder,
                codeGenerator.generate(CodeType.ASN),
                null,
                request.description(),
                AsnStatus.REJECTED
        );
        asnRepository.save(rejectedAsn);
    }


    private PurchaseOrder findAndValidatePurchaseOrder(Vendor vendor, String orderCode) {
        PurchaseOrder purchaseOrder = purchaseOrderRepository.findByOrderCode(orderCode)
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));

        Long purchaseOrderVendorId = purchaseOrder.getVendor().getId();
        if (!purchaseOrderVendorId.equals(vendor.getId())) {
            throw new AsnException(VENDOR_MISMATCH);
        }

        return purchaseOrder;
    }
}
