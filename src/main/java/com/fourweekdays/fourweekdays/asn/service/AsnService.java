package com.fourweekdays.fourweekdays.asn.service;

import com.fourweekdays.fourweekdays.asn.exception.ASNException;
import com.fourweekdays.fourweekdays.asn.model.dto.request.PurchaseOrderRejectRequest;
import com.fourweekdays.fourweekdays.asn.model.dto.response.AsnResponse;
import com.fourweekdays.fourweekdays.asn.model.dto.request.AsnReceiveRequest;
import com.fourweekdays.fourweekdays.asn.model.dto.response.AsnReceiveResponse;
import com.fourweekdays.fourweekdays.asn.model.entity.Asn;
import com.fourweekdays.fourweekdays.asn.repository.AsnRepository;
import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.inbound.service.InboundService;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.asn.exception.ASNExceptionType.ASN_NOT_FOUND;
import static com.fourweekdays.fourweekdays.asn.exception.ASNExceptionType.VENDOR_MISMATCH;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_CANNOT_REJECT;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus.APPROVED;
import static com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus.AWAITING_DELIVERY;

@Transactional(readOnly = true)
@RequiredArgsConstructor
@Service
public class AsnService {

    private final String ASN_CODE_PREFIX = "ASN";

    private final AsnRepository asnRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final InboundService inboundService;
    private final CodeGenerator codeGenerator;

    @Transactional
    public AsnReceiveResponse receiveAsn(Vendor vendor, AsnReceiveRequest request) {
        PurchaseOrder purchaseOrder = purchaseOrderRepository.findByOrderCode(request.orderCode())
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));

        Long purchaseOrderVendorId = purchaseOrder.getVendor().getId();
        if (!purchaseOrderVendorId.equals(vendor.getId())) {
            throw new ASNException(VENDOR_MISMATCH);
        }

        Asn asn = Asn.create(
                vendor,
                purchaseOrder,
                codeGenerator.generate(ASN_CODE_PREFIX),
                request.expectedDate(),
                request.description()
        );
        asnRepository.save(asn);

        // inbound 자동 생성
        inboundService.createByPurchaseOrder(purchaseOrder);

        return AsnReceiveResponse.builder()
                .asnCode(asn.getAsnCode())
                .message("ASN이 성공적으로 등록되었습니다")
                .build();
    }

    @Transactional
    public void rejectPurchaseOrderByVendor(Vendor vendor, PurchaseOrderRejectRequest request) {
        PurchaseOrder purchaseOrder = purchaseOrderRepository.findByOrderCode(request.orderCode())
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));

        Long purchaseOrderVendorId = purchaseOrder.getVendor().getId();
        if (!purchaseOrderVendorId.equals(vendor.getId())) {
            throw new ASNException(VENDOR_MISMATCH);
        }

        if (purchaseOrder.getStatus() != APPROVED) {
            throw new PurchaseOrderException(PURCHASE_ORDER_CANNOT_REJECT);
        }

        purchaseOrder.rejectByVendor(request.description());
    }

    public AsnResponse asnDetail(Long asnId) {
        Asn asn = asnRepository.findById(asnId)
                .orElseThrow(() -> new ASNException(ASN_NOT_FOUND));
        return AsnResponse.toDto(asn);
    }

    public Page<AsnResponse> asnListByPaging(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Asn> pageList = asnRepository.findAllWithPaging(pageable);
        return pageList.map(AsnResponse::toDto);
    }
}
