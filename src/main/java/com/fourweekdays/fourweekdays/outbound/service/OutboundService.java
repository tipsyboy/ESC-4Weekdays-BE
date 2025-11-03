package com.fourweekdays.fourweekdays.outbound.service;

import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.inventory.exception.InventoryException;
import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import com.fourweekdays.fourweekdays.inventory.repository.InventoryRepository;
import com.fourweekdays.fourweekdays.location.repository.LocationRepository;
import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.order.exception.OrderException;
import com.fourweekdays.fourweekdays.order.model.entity.Order;
import com.fourweekdays.fourweekdays.order.model.entity.OrderStatus;
import com.fourweekdays.fourweekdays.order.repository.OrderRepository;
import com.fourweekdays.fourweekdays.outbound.exception.OutboundException;
import com.fourweekdays.fourweekdays.outbound.model.dto.request.OutboundCreateDto;
import com.fourweekdays.fourweekdays.outbound.model.dto.request.OutboundInspectionRequest;
import com.fourweekdays.fourweekdays.outbound.model.dto.response.OutboundReadDto;
import com.fourweekdays.fourweekdays.outbound.model.entity.*;
import com.fourweekdays.fourweekdays.outbound.repository.OutboundInventoryHistoryRepository;
import com.fourweekdays.fourweekdays.outbound.repository.OutboundRepository;
import com.fourweekdays.fourweekdays.tasks.factory.OutboundTaskFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static com.fourweekdays.fourweekdays.inventory.exception.InventoryExceptionType.INSUFFICIENT_INVENTORY;
import static com.fourweekdays.fourweekdays.inventory.exception.InventoryExceptionType.INVENTORY_NOT_FOUND;
import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.order.exception.OrderExceptionType.ORDER_CANNOT_APPROVED;
import static com.fourweekdays.fourweekdays.order.exception.OrderExceptionType.ORDER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.outbound.exception.OutboundExceptionType.*;

@Service
@RequiredArgsConstructor
@Transactional
public class OutboundService {

    private static final String OUTBOUND_CODE_PREFIX = "OB";

    private final MemberRepository memberRepository;
    private final OutboundRepository outboundRepository;
    private final CodeGenerator codeGenerator;
    private final OrderRepository orderRepository;
    private final OutboundTaskFactory otfTaskFactory;
    private final LocationRepository locationRepository;
    private final InventoryRepository inventoryRepository;
    private final OutboundInventoryHistoryRepository outboundHistoryRepository;

    // 재고 감소
    @Transactional
    public void destroyOrDecreaseFromOutbound(Long outboundId) {
        List<OutboundInventoryHistory> allHistories = new ArrayList<>();

        Outbound outbound = outboundRepository.findByIdWithItemsAndProduct(outboundId)
                .orElseThrow(() -> new OutboundException(OUTBOUND_NOT_FOUND));

        if (outbound.getItems().isEmpty()) {
            throw new OutboundException(OUTBOUND_PRODUCT_NOT_FOUND);
        }
        List<OutboundProductItem> items = outbound.getItems();

        for (OutboundProductItem item : items) {
            List<OutboundInventoryHistory> histories =
                    decreaseInventoryByFIFO(
                            item.getProduct().getId(),
                            item.getOrderedQuantity(),
                            outbound
                    );
            allHistories.addAll(histories);
        }

        if (!allHistories.isEmpty()) {
            outboundHistoryRepository.saveAll(allHistories);
        }
    }


    // 출고 생성
// 주문과 완전 동일하게 생성되는 시나리오로 진행하겠음
    @Transactional
    public Long createOutbound(OutboundCreateDto dto) {

        // member와 order 검증
        Order order = verification(dto);

        // Outboun Entity 만들기
        Outbound outbound = createBaseOutbound(dto);

        // order에 상품 목록으로 OutboundProductItems 만들기
        addItemsFromOrder(outbound, order);

        // TODO addDirectItems x 일단 아이템을 추가로 받지 않게 하겠음

        return outboundRepository.save(outbound).getId();
    }

    // 출고 승인
    @Transactional
    public void approveOutbound(Long id) {
        Outbound outbound = chekOutbound(id);
        outbound.updateStatus(OutboundStatus.APPROVED);

        // 출고 작업 생성
        otfTaskFactory.createPickingTask(id);
        destroyOrDecreaseFromOutbound(id);
    }

    // 출고 거절
    @Transactional
    public void cancelledOutbound(Long id) {
        Outbound outbound = chekOutbound(id);

        if (outbound.getStatus() != OutboundStatus.APPROVED && outbound.getStatus() != OutboundStatus.REQUESTED) {
            throw new OutboundException(OUTBOUND_CANNOT_CANCEL);
        }
        outbound.updateStatus(OutboundStatus.CANCELLED);
        // TODO 재고 차감되었던만큼 증가

    }

    // TODO task가 작업 착수 -> 피킹중
    @Transactional
    public void updatePicking(Long id) {
        Outbound outbound = chekOutbound(id);
        outbound.updateStatus(OutboundStatus.PICKING);
    }

    // TODO task가 피킹 완료 -> 검수중
    @Transactional
    public void updatePacking(Long id) {
        Outbound outbound = chekOutbound(id);
        outbound.updateStatus(OutboundStatus.INSPECTION);
    }

    // 검수 완료 작업
    @Transactional
    public void updateInspection(Long id, List<OutboundInspectionRequest> requestList) {
        Outbound outbound = chekOutbound(id);

        if (outbound.getStatus() != OutboundStatus.INSPECTION) {
            throw new OutboundException(OUTBOUND_INVALID_STATUS_FOR_INSPECTION);
        }

        for (OutboundInspectionRequest request : requestList) {
            OutboundProductItem item = outbound.findByItemId(request.getOutboundProductid())
                    .orElseThrow(() -> new OutboundException(OUTBOUND_PRODUCT_NOT_FOUND));
            item.updateInspectionResult(request.getOrderedQuantity());
        }

        // 검수 완료 -> 패킹작업으로 변경
        outbound.updateStatus(OutboundStatus.PACKING);
    }

    // TODO 패킹완료 -> 출하
    @Transactional
    public void updateShipped(Long id) {
        Outbound outbound = chekOutbound(id);
        Order order = orderRepository.findById(outbound.getOrder().getOrderId())
                .orElseThrow(() -> new OrderException(ORDER_NOT_FOUND));
        order.updateShipped();
        outbound.updateStatus(OutboundStatus.SHIPPED);
    }

    // 출고 목록 조회
    public List<OutboundReadDto> getOutboundList() {
        return null;
    }

    // 출고 상세 조회
    public OutboundReadDto getOutboundDetails(Long id) {
        return null;
    }

    // 재고 감소 로직
    private List<OutboundInventoryHistory> decreaseInventoryByFIFO(Long productId, Integer requiredQuantity, Outbound outbound) {
        List<OutboundInventoryHistory> histories = new ArrayList<>();
        Integer remainingQuantity = requiredQuantity;

        List<Inventory> inventories = inventoryRepository
                .findAllByProductIdOrderByLotNumberAsc(productId);
        if (inventories.isEmpty()) {
            throw new InventoryException(INVENTORY_NOT_FOUND);
        }

        for (Inventory inventory : inventories) {
            if (remainingQuantity <= 0) {
                break;
            }
            // 이미 재고가 0일 경우 (그렇다면 같은 상품에 대한 출고요청이 들어와있는 상태일것
            // 1번 출고 -> 상품 30개 출고 중, 2번 출고 -> 40개 -> 남은 재고 0 2번이 먼저 출하작업 완료 재고 삭제 이러면 어떡함
            // 소프트 딜리트하면 됨
            Integer currentStock = inventory.getQuantity();
            if (currentStock <= 0) {
                continue;
            }
            int decreaseAmount = Math.min(currentStock, remainingQuantity);
            inventory.decrease(decreaseAmount);

            OutboundInventoryHistory history = OutboundInventoryHistory.builder()
                    .outbound(outbound)
                    .inventory(inventory)
                    .product(inventory.getProduct())
                    .location(inventory.getLocation())
                    .quantityChanged(decreaseAmount)
                    .lotNumber(inventory.getLotNumber())
                    .build();

            histories.add(history);

            // 남은 수량 업데이트
            remainingQuantity -= decreaseAmount;
        }

        // 재고가 부족한 경우
        if (remainingQuantity > 0) {
            throw new InventoryException(INVENTORY_NOT_FOUND);
        }

        return histories;
    }

    private Order verification(OutboundCreateDto dto) {
        memberRepository.findById(dto.getMemberId())
                .orElseThrow(() -> new MemberException(MEMBER_NOT_FOUND));

        Order order = orderRepository.findById(dto.getOrderId())
                .orElseThrow(() -> new OrderException(ORDER_NOT_FOUND));

        if (!order.getStatus().equals(OrderStatus.APPROVED)) {
            throw new OrderException(ORDER_CANNOT_APPROVED);
        }

        if (outboundRepository.existsByOrder(order)) {
            throw new OutboundException(OUTBOUND_ORDER_EXISTENCE);
        }
        return order;
    }

    private Outbound createBaseOutbound(OutboundCreateDto dto) {
        String OutboundCode = codeGenerator.generate(OUTBOUND_CODE_PREFIX);
        OutboundStatus status = OutboundStatus.REQUESTED;

        return dto.toEntity(OutboundCode, status);
    }

    private void addItemsFromOrder(Outbound outbound, Order order) {
        order.getItems().forEach(opItem -> {
            OutboundProductItem outboundProductItem = OutboundProductItem.builder()
                    .product(opItem.getProduct())
                    .orderProductItem(opItem)
                    .orderedQuantity(opItem.getOrderedQuantity())
                    .description(opItem.getDescription())
                    .build();

            outboundProductItem.assignOutbound(outbound);
        });
    }

    private Outbound chekOutbound(Long id) {
        return outboundRepository.findById(id)
                .orElseThrow(() -> new OutboundException(OUTBOUND_NOT_FOUND));
    }
}
