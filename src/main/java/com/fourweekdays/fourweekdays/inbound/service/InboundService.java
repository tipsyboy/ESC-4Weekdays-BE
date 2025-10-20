package com.fourweekdays.fourweekdays.inbound.service;

import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.inbound.exception.InboundException;
import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundCreateRequestDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundItemDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundUpdateRequestDto;
import com.fourweekdays.fourweekdays.inbound.model.dto.response.InboundReadDto;
import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.inbound.model.entity.InboundProductItem;
import com.fourweekdays.fourweekdays.inbound.model.entity.InboundStatus;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.product.exception.ProductException;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType.INBOUND_NOT_FOUND;
import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_NOT_FOUND;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class InboundService {

    public static final String INBOUND_CODE_PREFIX = "IB";

    private final MemberRepository memberRepository;
    private final InboundRepository inboundRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final ProductRepository productRepository;
    private final CodeGenerator codeGenerator;

    @Transactional
    public Long create(InboundCreateRequestDto requestDto) {
        requestDto.validate();

        // 1. Inbound Entity
        Inbound inbound = createBaseInbound(requestDto);

        // 2. 발주서를 통한 입고 상품 생성
        addItemsFromPurchaseOrder(requestDto, inbound);

        // 3. 상품을 통한 입고 상품 생성
        addDirectItems(requestDto, inbound);

        return inboundRepository.save(inbound).getId();
    }


    public InboundReadDto inboundDetail(Long id) {
        Inbound entity = inboundRepository.findById(id)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));
        return InboundReadDto.from(entity);
    }

    public List<InboundReadDto> inboundList() {
        // TODO: paging 처리
        return inboundRepository.findAll().stream()
                .map(InboundReadDto::from)
                .toList();
    }

    @Transactional
    public Long update(InboundUpdateRequestDto requestDto, Long id) {
        Member manager = memberRepository.findById(requestDto.getMemberId())
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));

        Inbound inbound = inboundRepository.findById(id)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));

        inbound.updateData(manager.getName(), requestDto.getScheduledDate(), requestDto.getDescription());

        if (requestDto.getItems() != null && !requestDto.getItems().isEmpty()) {
            List<InboundProductItem> items = requestDto.getItems().stream()
                    .map(itemDto -> convertToEntity(itemDto, inbound))
                    .toList();
            inbound.updateItems(items);
        }

        return inbound.getId();
    }

    // 소프트 딜리트
    @Transactional
    public void softDelete(Long id) {
        Inbound inbound = inboundRepository.findById(id)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));
        inbound.cancelInbound();
    }

    // TODO: 하드 딜리트 - 꼭 구현을 해야하나?

    private Inbound createBaseInbound(InboundCreateRequestDto requestDto) {
        Member manager = memberRepository.findById(requestDto.getMemberId())
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));

        return Inbound.builder()
                .inboundCode(codeGenerator.generate(INBOUND_CODE_PREFIX))
                .status(InboundStatus.SCHEDULED)
                .managerName(manager.getName())
                .scheduledDate(requestDto.getScheduledDate())
                .description(requestDto.getDescription())
                .build();
    }

    private void addItemsFromPurchaseOrder(InboundCreateRequestDto requestDto, Inbound inbound) {
        if (requestDto.getPurchaseOrderId() == null) {
            return;
        }

        PurchaseOrder purchaseOrder = purchaseOrderRepository.findById(requestDto.getPurchaseOrderId())
                .orElseThrow(() -> new PurchaseOrderException(PURCHASE_ORDER_NOT_FOUND));

        inbound.updatePurchaseOrder(purchaseOrder);

        purchaseOrder.getItems().forEach(poItem -> {
            InboundProductItem inboundItem = InboundProductItem.builder()
                    .product(poItem.getProduct())
                    .purchaseOrderProductItem(poItem)
                    .receivedQuantity(0)
                    .description(poItem.getDescription())
                    .build();

            inboundItem.assignInbound(inbound);
        });
    }

    private void addDirectItems(InboundCreateRequestDto requestDto, Inbound inbound) {
        if (requestDto.getItems() == null || requestDto.getItems().isEmpty()) {
            return;
        }

        requestDto.getItems().forEach(itemDto -> {
            Product product = productRepository.findById(itemDto.getProductId())
                    .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

            InboundProductItem inboundItem = InboundProductItem.builder()
                    .product(product)
                    .inbound(inbound)
                    .purchaseOrderProductItem(null)
                    .receivedQuantity(itemDto.getQuantity())
                    .description(itemDto.getDescription())
                    .build();
        });
    }

    private InboundProductItem convertToEntity(InboundItemDto dto, Inbound inbound) {
        Product product = productRepository.findById(dto.getProductId())
                .orElseThrow(() -> new ProductException(PRODUCT_NOT_FOUND));

        return InboundProductItem.builder()
                .inbound(inbound)
                .product(product)
                .receivedQuantity(dto.getQuantity())
                .description(dto.getDescription())
                .build();
    }
}
