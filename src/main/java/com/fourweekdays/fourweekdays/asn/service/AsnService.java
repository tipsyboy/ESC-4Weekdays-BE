package com.fourweekdays.fourweekdays.asn.service;

import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.asn.domain.AsnItem;
import com.fourweekdays.fourweekdays.asn.domain.AsnStatus;
import com.fourweekdays.fourweekdays.asn.dto.AsnCreateItemRequest;
import com.fourweekdays.fourweekdays.asn.dto.AsnCreateRequest;
import com.fourweekdays.fourweekdays.asn.dto.AsnDetailResponse;
import com.fourweekdays.fourweekdays.asn.dto.AsnListResponse;
import com.fourweekdays.fourweekdays.asn.dto.AsnPageResponse;
import com.fourweekdays.fourweekdays.asn.dto.AsnSummaryResponse;
import com.fourweekdays.fourweekdays.asn.dto.AsnStatusUpdateRequest;
import com.fourweekdays.fourweekdays.asn.exception.AsnException;
import com.fourweekdays.fourweekdays.asn.repository.AsnRepository;
import com.fourweekdays.fourweekdays.auth.service.AuthAccessService;
import com.fourweekdays.fourweekdays.global.response.PageResponse;
import com.fourweekdays.fourweekdays.global.util.CodeGenerator;
import com.fourweekdays.fourweekdays.global.util.CodeType;
import com.fourweekdays.fourweekdays.inbound.service.InboundService;
import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.asn.exception.AsnExceptionType.ASN_ALREADY_EXISTS;
import static com.fourweekdays.fourweekdays.asn.exception.AsnExceptionType.ASN_INVALID_REQUEST;
import static com.fourweekdays.fourweekdays.asn.exception.AsnExceptionType.ASN_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_NOT_FOUND;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AsnService {

    private final AsnRepository asnRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final ProductRepository productRepository;
    private final CodeGenerator codeGenerator;
    private final InboundService inboundService;
    private final AuthAccessService authAccessService;

    @Transactional
    public AsnDetailResponse create(AsnCreateRequest request) {
        validateCreateStatus(request.status());

        PurchaseOrder purchaseOrder = purchaseOrderRepository.findById(request.purchaseOrderId())
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));
        authAccessService.assertVendorScope(purchaseOrder.getVendor().getId());

        if (purchaseOrder.getStatus() != PurchaseOrderStatus.ORDERED) {
            throw new AsnException(ASN_INVALID_REQUEST);
        }

        if (asnRepository.existsByPurchaseOrderId(request.purchaseOrderId())) {
            throw new AsnException(ASN_ALREADY_EXISTS);
        }

        validateCreateRequest(request);

        List<AsnCreateItemRequest> items = request.items() == null ? List.of() : request.items();
        Map<Long, Product> productMap = productRepository.findAllById(
                        items.stream().map(AsnCreateItemRequest::productId).toList()
                ).stream()
                .collect(java.util.stream.Collectors.toMap(Product::getId, Function.identity()));

        Asn asn = Asn.builder()
                .asnNumber(codeGenerator.generate(CodeType.ASN))
                .purchaseOrder(purchaseOrder)
                .expectedArrivalAt(resolveExpectedArrivalAt(request.expectedArrivalAt(), purchaseOrder.getExpectedInboundDate()))
                .status(request.status())
                .vehicleInfo(request.vehicleInfo())
                .contactName(request.contactName())
                .contactPhoneNumber(request.contactPhoneNumber())
                .note(request.note())
                .receivedAt(request.status() == AsnStatus.RECEIVED ? LocalDateTime.now() : null)
                .build();

        for (AsnCreateItemRequest itemRequest : items) {
            Product product = productMap.get(itemRequest.productId());

            if (product == null) {
                throw new AsnException(ASN_INVALID_REQUEST);
            }

            boolean belongsToPurchaseOrder = purchaseOrder.getItems().stream()
                    .anyMatch(item -> item.getProduct().getId().equals(product.getId()));

            if (!belongsToPurchaseOrder) {
                throw new AsnException(ASN_INVALID_REQUEST);
            }

            asn.addItem(AsnItem.builder()
                    .product(product)
                    .announcedQuantity(itemRequest.announcedQuantity())
                    .build());
        }

        Asn savedAsn = asnRepository.save(asn);

        if (savedAsn.getStatus() == AsnStatus.RECEIVED) {
            inboundService.createByPurchaseOrder(savedAsn.getPurchaseOrder());
            savedAsn.markScheduled();
        }

        return AsnDetailResponse.from(savedAsn);
    }

    public AsnPageResponse readAll(int page, int size) {
        Long vendorId = authAccessService.currentVendorIdForVendorManagerOrNull();
        List<AsnListResponse> allAsns = (vendorId == null
                ? asnRepository.findAllByOrderByIdDesc()
                : asnRepository.findAllByPurchaseOrderVendorIdOrderByIdDesc(vendorId)).stream()
                .map(AsnListResponse::from)
                .toList();

        PageRequest pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "id"));
        Page<AsnListResponse> pageResponse = (vendorId == null
                ? asnRepository.findAll(pageable)
                : asnRepository.findAllByPurchaseOrderVendorIdOrderByIdDesc(vendorId, pageable))
                .map(AsnListResponse::from);

        return AsnPageResponse.from(
                PageResponse.from(pageResponse),
                AsnSummaryResponse.from(allAsns)
        );
    }

    public AsnDetailResponse read(Long id) {
        Asn asn = getAsn(id);
        authAccessService.assertVendorScope(asn.getPurchaseOrder().getVendor().getId());
        return AsnDetailResponse.from(asn);
    }

    public AsnDetailResponse readByPurchaseOrderId(Long purchaseOrderId) {
        PurchaseOrder purchaseOrder = purchaseOrderRepository.findById(purchaseOrderId)
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));
        authAccessService.assertVendorScope(purchaseOrder.getVendor().getId());

        return asnRepository.findByPurchaseOrderId(purchaseOrderId)
                .map(AsnDetailResponse::from)
                .orElseThrow(() -> new AsnException(ASN_NOT_FOUND));
    }

    @Transactional
    public AsnDetailResponse updateStatus(Long id, AsnStatusUpdateRequest request) {
        Asn asn = getAsn(id);
        authAccessService.assertVendorScope(asn.getPurchaseOrder().getVendor().getId());
        validateStatusTransition(asn.getStatus(), request.status());

        if (request.status() == AsnStatus.RECEIVED) {
            asn.markReceived(LocalDateTime.now());
            inboundService.createByPurchaseOrder(asn.getPurchaseOrder());
            asn.markScheduled();
            return AsnDetailResponse.from(asn);
        }

        if (request.status() == AsnStatus.SCHEDULED) {
            asn.markScheduled();
            return AsnDetailResponse.from(asn);
        }

        if (request.status() == AsnStatus.REJECTED) {
            asn.markRejected();
            return AsnDetailResponse.from(asn);
        }

        throw new AsnException(ASN_INVALID_REQUEST);
    }

    private Asn getAsn(Long id) {
        return asnRepository.findById(id)
                .orElseThrow(() -> new AsnException(ASN_NOT_FOUND));
    }

    private void validateCreateStatus(AsnStatus status) {
        if (status != AsnStatus.WAITING && status != AsnStatus.RECEIVED && status != AsnStatus.REJECTED) {
            throw new AsnException(ASN_INVALID_REQUEST);
        }
    }

    private void validateStatusTransition(AsnStatus currentStatus, AsnStatus nextStatus) {
        boolean valid = switch (currentStatus) {
            case WAITING -> nextStatus == AsnStatus.RECEIVED || nextStatus == AsnStatus.REJECTED;
            case RECEIVED -> nextStatus == AsnStatus.SCHEDULED;
            case REJECTED, SCHEDULED, ACCEPTED -> false;
        };

        if (!valid) {
            throw new AsnException(ASN_INVALID_REQUEST);
        }
    }

    private void validateCreateRequest(AsnCreateRequest request) {
        if (request.status() == AsnStatus.RECEIVED) {
            if (request.expectedArrivalAt() == null) {
                throw new AsnException(ASN_INVALID_REQUEST);
            }

            if (request.items() == null || request.items().isEmpty()) {
                throw new AsnException(ASN_INVALID_REQUEST);
            }

            return;
        }

        if (request.status() == AsnStatus.REJECTED && (request.note() == null || request.note().isBlank())) {
            throw new AsnException(ASN_INVALID_REQUEST);
        }
    }

    private LocalDateTime resolveExpectedArrivalAt(LocalDateTime expectedArrivalAt, LocalDate expectedInboundDate) {
        if (expectedArrivalAt != null) {
            return expectedArrivalAt;
        }

        if (expectedInboundDate != null) {
            return expectedInboundDate.atTime(9, 0);
        }

        return LocalDateTime.now();
    }
}
