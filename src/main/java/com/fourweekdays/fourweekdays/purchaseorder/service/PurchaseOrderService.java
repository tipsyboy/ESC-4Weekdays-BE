package com.fourweekdays.fourweekdays.purchaseorder.service;

import com.fourweekdays.fourweekdays.global.util.CodeGenerator;
import com.fourweekdays.fourweekdays.global.util.CodeType;
import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderCreateItemRequest;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderCreateRequest;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderDetailResponse;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderListResponse;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderSearchCondition;
import com.fourweekdays.fourweekdays.purchaseorder.dto.PurchaseOrderStatusUpdateRequest;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderProduct;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_INVALID_STATUS_CHANGE;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_VENDOR_MISMATCH;
import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PurchaseOrderService {

    private final PurchaseOrderRepository purchaseOrderRepository;
    private final VendorRepository vendorRepository;
    private final ProductRepository productRepository;
    private final CodeGenerator codeGenerator;

    @Transactional
    public PurchaseOrderDetailResponse create(PurchaseOrderCreateRequest request) {
        validateCreateStatus(request.status());

        Vendor vendor = vendorRepository.findById(request.vendorId())
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));

        List<Long> productIds = request.items().stream()
                .map(PurchaseOrderCreateItemRequest::productId)
                .toList();

        List<Product> products = productRepository.findAllById(productIds);

        Map<Long, Product> productMap = products.stream()
                .collect(Collectors.toMap(Product::getId, Function.identity()));

        String purchaseOrderNumber = codeGenerator.generate(CodeType.PURCHASE_ORDER);
        PurchaseOrder purchaseOrder = PurchaseOrder.builder()
                .orderCode(purchaseOrderNumber)
                .purchaseOrderNumber(purchaseOrderNumber)
                .vendor(vendor)
                .requesterName(request.requesterName())
                .requestedAt(LocalDateTime.now())
                .orderDate(LocalDateTime.now())
                .expectedInboundDate(request.expectedInboundDate())
                .expectedDate(request.expectedInboundDate() != null ? request.expectedInboundDate().atStartOfDay() : null)
                .status(request.status())
                .requestMemo(request.requestMemo())
                .description(request.requestMemo())
                .build();

        for (PurchaseOrderCreateItemRequest itemRequest : request.items()) {
            Product product = productMap.get(itemRequest.productId());

            if (product == null) {
                throw new PurchaseOrderException(PURCHASE_ORDER_PRODUCT_NOT_FOUND);
            }

            if (!product.getVendor().getId().equals(vendor.getId())) {
                throw new PurchaseOrderException(PURCHASE_ORDER_VENDOR_MISMATCH);
            }

            purchaseOrder.addItem(PurchaseOrderProduct.builder()
                    .product(product)
                    .orderedQuantity(itemRequest.quantity())
                    .orderUnitPrice(itemRequest.unitPrice())
                    .build());
        }

        purchaseOrder.calculateTotalAmount();
        return PurchaseOrderDetailResponse.from(purchaseOrderRepository.save(purchaseOrder));
    }

    public Page<PurchaseOrderListResponse> search(PurchaseOrderSearchCondition condition) {
        Pageable pageable = PageRequest.of(
                condition.pageOrDefault(),
                condition.sizeOrDefault(),
                Sort.by(
                        Sort.Direction.fromString(condition.sortDirectionOrDefault()),
                        resolveSortBy(condition.sortByOrDefault())
                )
        );

        return purchaseOrderRepository.search(
                        normalizeText(condition.vendorName()),
                        normalizeText(condition.requesterName()),
                        condition.status(),
                        condition.expectedInboundDate(),
                        normalizeText(condition.approverName()),
                        normalizeText(condition.purchaseOrderNumber()),
                        normalizeText(condition.memoKeyword()),
                        pageable
                )
                .map(PurchaseOrderListResponse::from);
    }

    public PurchaseOrderDetailResponse read(Long id) {
        return PurchaseOrderDetailResponse.from(getPurchaseOrder(id));
    }

    @Transactional
    public PurchaseOrderDetailResponse updateStatus(Long id, PurchaseOrderStatusUpdateRequest request) {
        PurchaseOrder purchaseOrder = getPurchaseOrder(id);
        validateStatusTransition(purchaseOrder.getStatus(), request.status());

        if (request.status() == PurchaseOrderStatus.APPROVED) {
            String approverName = hasText(request.approverName()) ? request.approverName() : "운영관리자";
            purchaseOrder.approve(approverName, request.approvalMemo(), LocalDateTime.now());
            return PurchaseOrderDetailResponse.from(purchaseOrder);
        }

        if (request.status() == PurchaseOrderStatus.REJECTED) {
            purchaseOrder.reject(request.approvalMemo());
            return PurchaseOrderDetailResponse.from(purchaseOrder);
        }

        if (request.status() == PurchaseOrderStatus.ORDERED) {
            purchaseOrder.markOrdered(LocalDateTime.now());
            return PurchaseOrderDetailResponse.from(purchaseOrder);
        }

        if (request.status() == PurchaseOrderStatus.CANCELED) {
            purchaseOrder.cancelVibe();
            return PurchaseOrderDetailResponse.from(purchaseOrder);
        }

        purchaseOrder.changeStatus(request.status());
        return PurchaseOrderDetailResponse.from(purchaseOrder);
    }

    private PurchaseOrder getPurchaseOrder(Long id) {
        return purchaseOrderRepository.findById(id)
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));
    }

    private void validateCreateStatus(PurchaseOrderStatus status) {
        if (status != PurchaseOrderStatus.DRAFT && status != PurchaseOrderStatus.APPROVAL_PENDING) {
            throw new PurchaseOrderException(PURCHASE_ORDER_INVALID_STATUS_CHANGE);
        }
    }

    private void validateStatusTransition(PurchaseOrderStatus currentStatus, PurchaseOrderStatus nextStatus) {
        boolean valid = switch (currentStatus) {
            case DRAFT -> nextStatus == PurchaseOrderStatus.APPROVAL_PENDING || nextStatus == PurchaseOrderStatus.CANCELED;
            case APPROVAL_PENDING -> nextStatus == PurchaseOrderStatus.APPROVED
                    || nextStatus == PurchaseOrderStatus.REJECTED
                    || nextStatus == PurchaseOrderStatus.CANCELED;
            case APPROVED -> nextStatus == PurchaseOrderStatus.ORDERED || nextStatus == PurchaseOrderStatus.CANCELED;
            case REJECTED, CANCELED, ORDERED -> false;
            case REQUESTED, AWAITING_DELIVERY, COMPLETED, CANCELLED -> false;
        };

        if (!valid) {
            throw new PurchaseOrderException(PURCHASE_ORDER_INVALID_STATUS_CHANGE);
        }
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }

    private String resolveSortBy(String sortBy) {
        if (sortBy == null || sortBy.isBlank()) {
            return "updatedAt";
        }

        return switch (sortBy) {
            case "purchaseOrderNumber", "vendorName", "requesterName", "approverName",
                    "requestedAt", "approvedAt", "orderedAt", "expectedInboundDate",
                    "status", "createdAt", "updatedAt" -> sortBy;
            default -> "updatedAt";
        };
    }

    private String normalizeText(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim();
    }
}
