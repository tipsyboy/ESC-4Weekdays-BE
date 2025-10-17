package com.fourweekdays.fourweekdays.inbound.service;

import com.fourweekdays.fourweekdays.inbound.exception.InboundException;
import com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType;
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
import com.fourweekdays.fourweekdays.product.exception.ProductExceptionType;
import com.fourweekdays.fourweekdays.product.model.Product;
import com.fourweekdays.fourweekdays.product.repository.ProductRepository;
import com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderException;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import static com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType.INBOUND_NOT_FOUND;
import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.product.exception.ProductExceptionType.PRODUCT_NOT_FOUND;
import static com.fourweekdays.fourweekdays.purchaseorder.exception.PurchaseOrderExceptionType.PURCHASE_ORDER_NOT_FOUND;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class InboundService {

    private final MemberRepository memberRepository;
    private final InboundRepository inboundRepository;
    private final PurchaseOrderRepository purchaseOrderRepository;
    private final ProductRepository productRepository;

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
    public void softDelete(Long id) {
        Inbound inbound = inboundRepository.findById(id)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));
        inbound.cancelInbound();
    }

//    // 하드 딜리트
//    public void hardDelete(Long id) {
//        inboundRepository.deleteById(id);
//    }

    /**
     * TODO: Redis 분산 락을 사용한 순차 번호 생성으로 변경 필요
     * 현재는 임시로 UUID 기반 난수 사용 (동시성 이슈 없으나 가독성 낮음)
     *  1. Redis 분산 락 + 날짜 시퀀스
     *  2. DB 시퀀스 테이블 + 비관적 락
     *  3. MariaDB SEQUENCE 객체 활용
     */
    private String generateInboundNumber() {
        String datePrefix = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        String randomSuffix = UUID.randomUUID()
                .toString()
                .replace("-", "")
                .substring(0, 6)
                .toUpperCase();

        return String.format("IB-%s-%s", datePrefix, randomSuffix); // 예: IB-20251016-A7F3B2
    }

    private Inbound createBaseInbound(InboundCreateRequestDto requestDto) {
        Member manager = memberRepository.findById(requestDto.getMemberId())
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));

        return Inbound.builder()
                .inboundNumber(generateInboundNumber())
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
                    .purchaseOrderProductItem(null)
                    .receivedQuantity(itemDto.getQuantity())
                    .description(itemDto.getDescription())
                    .build();

            inboundItem.assignInbound(inbound);
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
