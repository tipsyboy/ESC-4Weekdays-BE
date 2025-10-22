package com.fourweekdays.fourweekdays.asn.service;

import com.fourweekdays.fourweekdays.asn.exception.ASNException;
import com.fourweekdays.fourweekdays.asn.model.dto.request.AsnReceiveRequest;
import com.fourweekdays.fourweekdays.asn.model.dto.response.AsnReceiveResponse;
import com.fourweekdays.fourweekdays.asn.model.entity.ASN;
import com.fourweekdays.fourweekdays.asn.repository.ASNRepository;
import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.inbound.service.InboundService;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.asn.exception.ASNExceptionType.ASN_DUPLICATION;
import static com.fourweekdays.fourweekdays.asn.exception.ASNExceptionType.VENDOR_MISMATCH;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_NOT_FOUND;

@RequiredArgsConstructor
@Service
public class AsnService {

    private final String ASN_CODE_PREFIX = "ASN";

    private final ASNRepository asnRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final InboundService inboundService;
    private final CodeGenerator codeGenerator;

    @Transactional
    public AsnReceiveResponse receiveAsn(Vendor vendor, AsnReceiveRequest request) {

        PurchaseOrder purchaseOrder = purchaseOrderRepository.findByOrderCode(request.orderCode())
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));

        if (!purchaseOrder.getVendor().equals(vendor)) {
            throw new ASNException(VENDOR_MISMATCH);
        }

        ASN asn = ASN.create(
                vendor,
                purchaseOrder,
                codeGenerator.generate(ASN_CODE_PREFIX),
                request.expectedDate()
        );
        asnRepository.save(asn);

        Long inboundId = inboundService.createByPurchaseOrder(purchaseOrder);

        return AsnReceiveResponse.builder()
                .asnCode(asn.getAsnCode())
                .message("ASN이 성공적으로 등록되었습니다")
                .build();
    }
}
