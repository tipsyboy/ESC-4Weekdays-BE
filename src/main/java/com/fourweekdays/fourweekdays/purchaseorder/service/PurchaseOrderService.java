package com.fourweekdays.fourweekdays.purchaseorder.service;

import com.fourweekdays.fourweekdays.common.email.EmailService;
import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderProductRequestDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderUpdateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderReadDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderProduct;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrderStatus;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.exception.VendorException;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.*;
import static com.fourweekdays.fourweekdays.vendor.exception.VendorExceptionType.VENDOR_NOT_FOUND;

@Transactional(readOnly = true)
@RequiredArgsConstructor
//@Service
public class PurchaseOrderService {

    private static final String PURCHASE_ORDER_CODE_PREFIX = "PO";

    private final PurchaseOrderRepository purchaseOrderRepository;
    private final VendorRepository vendorRepository;
    private final ProductRepository productRepository;
    private final CodeGenerator codeGenerator;
    private final EmailService emailService;
    private final MemberRepository memberRepository;

    @Transactional
    public Long create(PurchaseOrderCreateDto requestDto, Long managerId) {
        Vendor vendor = vendorRepository.findById(requestDto.getVendorId())
                .orElseThrow(() -> new VendorException(VENDOR_NOT_FOUND));

        Member manager = memberRepository.findById(managerId)
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));

        PurchaseOrder purchaseOrder = createPurchaseOrder(vendor, manager, requestDto);
        createOrderProducts(requestDto.getItems(), purchaseOrder);
        purchaseOrder.calculateTotalAmount();

        return purchaseOrderRepository.save(purchaseOrder).getId();
    }

    // 단건 조회
    public PurchaseOrderReadDto findByPurchaseOrderId(Long id) {
        PurchaseOrder purchaseOrder = findByIdOrThrow(id);
        return PurchaseOrderReadDto.toDto(purchaseOrder);
    }

    // 목록 조회
    public Page<PurchaseOrderReadDto> findPurchaseOrderListByPaging(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<PurchaseOrder> list = purchaseOrderRepository.findAllWithPaging(pageable);
        return list.map(PurchaseOrderReadDto::toDto);
    }

    @Transactional
    public Long update(Long id, PurchaseOrderUpdateDto requestDto) {
        PurchaseOrder order = findByIdOrThrow(id);

        if (order.getStatus() != PurchaseOrderStatus.REQUESTED) {
            throw new PurchaseOrderException(PURCHASE_ORDER_CANNOT_UPDATE_AFTER_APPROVAL);
        }

        order.update(requestDto.expectedDate(), requestDto.description());
        order.clearItems();
        createOrderProducts(requestDto.items(), order);

        return order.getId();
    }

    // 발주 취소
    @Transactional
    public void cancel(Long id) {
        PurchaseOrder order = findByIdOrThrow(id);
        if (order.getStatus() != PurchaseOrderStatus.REQUESTED) {
            throw new PurchaseOrderException(PURCHASE_ORDER_CANNOT_CANCEL_AFTER_APPROVAL);
        }
        order.cancel();
    }

    // 발주 승인
    @Transactional
    public Long approve(Long id) throws MessagingException {
        PurchaseOrder purchaseOrder = findByIdOrThrow(id);
        purchaseOrder.approve(); // 상태 변경
        emailService.sendPurchaseOrderMail(purchaseOrder); // 외부 업체 담당자에게 Email 전송

        return id;
    }

    @Transactional
    public void confirm(Long id) {
        PurchaseOrder order = findByIdOrThrow(id);
        if (order.getStatus() != PurchaseOrderStatus.APPROVED) {
            throw new PurchaseOrderException(PURCHASE_ORDER_INVALID_STATUS_CHANGE);
        }
        order.awaitDelivery();
    }

    // 입고 완료 처리
    @Transactional
    public void completeInbound(Long id) {
        PurchaseOrder order = findByIdOrThrow(id);
        if (order.getStatus() != PurchaseOrderStatus.AWAITING_DELIVERY) {
            throw new PurchaseOrderException(PURCHASE_ORDER_INVALID_STATUS_CHANGE);
        }
        order.completeDelivery();
    }


    private PurchaseOrder findByIdOrThrow(Long id) {
        return purchaseOrderRepository.findById(id)
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));
    }

    private PurchaseOrder createPurchaseOrder(Vendor vendor, Member manager, PurchaseOrderCreateDto dto) {
        return PurchaseOrder.builder()
                .vendor(vendor)
                .manager(manager)
                .orderCode(codeGenerator.generate(PURCHASE_ORDER_CODE_PREFIX))
                .orderDate(LocalDateTime.now())
                .expectedDate(dto.getExpectedDate())
                .description(dto.getDescription())
                .status(PurchaseOrderStatus.REQUESTED)
                .build();
    }

    private List<PurchaseOrderProduct> createOrderProducts(List<PurchaseOrderProductRequestDto> items, PurchaseOrder order) {
        return items.stream()
                .map(item -> createOrderProduct(item, order))
                .toList();
    }

    private PurchaseOrderProduct createOrderProduct(PurchaseOrderProductRequestDto dto, PurchaseOrder order) {
        Product product = productRepository.findById(dto.getProductId())
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

        PurchaseOrderProduct orderProduct = PurchaseOrderProduct.builder()
                .product(product)
                .orderedQuantity(dto.getOrderedQuantity())
                .description(dto.getDescription())
                .build();

        order.addItem(orderProduct);
        return orderProduct;
    }
}
