package com.fourweekdays.fourweekdays.outbound.service;

import com.fourweekdays.fourweekdays.common.generator.CodeGenerator;
import com.fourweekdays.fourweekdays.inventory.exception.InventoryException;
import com.fourweekdays.fourweekdays.inventory.model.entity.Inventory;
import com.fourweekdays.fourweekdays.inventory.repository.InventoryRepository;
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
import com.fourweekdays.fourweekdays.tasks.exception.TaskException;
import com.fourweekdays.fourweekdays.tasks.factory.OutboundTaskFactory;
import com.fourweekdays.fourweekdays.tasks.model.entity.Task;
import com.fourweekdays.fourweekdays.tasks.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static com.fourweekdays.fourweekdays.inventory.exception.InventoryExceptionType.INVENTORY_NOT_FOUND;
import static com.fourweekdays.fourweekdays.member.exception.MemberExceptionType.MEMBER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.order.exception.OrderExceptionType.ORDER_CANNOT_APPROVED;
import static com.fourweekdays.fourweekdays.order.exception.OrderExceptionType.ORDER_NOT_FOUND;
import static com.fourweekdays.fourweekdays.outbound.exception.OutboundExceptionType.*;
import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.OUTBOUND_HISTORY_ALREADY_PROCESSED;
import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.TASK_NOT_FOUND;

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
    private final InventoryRepository inventoryRepository;
    private final OutboundInventoryHistoryRepository outboundHistoryRepository;
    private final TaskRepository taskRepository;

    // 출고 생성
    @Transactional
    public Long createOutbound(OutboundCreateDto dto) {
        Order order = verification(dto);
        Outbound outbound = createBaseOutbound(dto);
        addItemsFromOrder(outbound, order);

        return outboundRepository.save(outbound).getId();
    }

    // 출고 승인
    @Transactional
    public void approveOutbound(Long id) {
        Outbound outbound = checkOutbound(id);
        outbound.updateStatus(OutboundStatus.APPROVED);
        Long taskId = otfTaskFactory.createPickingTask(id);
        destroyOrDecreaseFromOutbound(id, taskId);
    }

    // 출고 취소
    @Transactional
    public void cancelledOutbound(Long id) {
        Outbound outbound = checkOutbound(id);

        if (outbound.getStatus() != OutboundStatus.APPROVED && outbound.getStatus() != OutboundStatus.REQUESTED) {
            throw new OutboundException(OUTBOUND_CANNOT_CANCEL);
        }
        outbound.updateStatus(OutboundStatus.CANCELLED);

        List<OutboundInventoryHistory> histories =
                outboundHistoryRepository.findAllByOutboundIdWithInventory(id);

        validateAllHistoriesArePending(histories);

        recoverInventoryFromOutboundHistory(histories);
    }

//    // TODO task 작업 착수 -> 피킹중
//    @Transactional
//    public void updatePicking(Long id) {
//        Outbound outbound = checkOutbound(id);
//        outbound.updateStatus(OutboundStatus.PICKING);
//    }
//
//    // TODO task가 피킹 완료 -> 검수중
//    @Transactional
//    public void updatePacking(Long id) {
//        Outbound outbound = checkOutbound(id);
//        outbound.updateStatus(OutboundStatus.INSPECTION);
//    }
//
//    // 검수 완료 작업
//    @Transactional
//    public void updateInspection(Long id, List<OutboundInspectionRequest> requestList) {
//        Outbound outbound = checkOutbound(id);
//
//        if (outbound.getStatus() != OutboundStatus.INSPECTION) {
//            throw new OutboundException(OUTBOUND_INVALID_STATUS_FOR_INSPECTION);
//        }
//
//        for (OutboundInspectionRequest request : requestList) {
//            OutboundProductItem item = outbound.findByItemId(request.getOutboundProductid())
//                    .orElseThrow(() -> new OutboundException(OUTBOUND_PRODUCT_NOT_FOUND));
//            item.updateInspectionResult(request.getOrderedQuantity());
//        }
//
//        // 검수 완료 -> 패킹작업으로 변경
//        outbound.updateStatus(OutboundStatus.PACKING);
//    }
//
//    // TODO 패킹완료 -> 출하
//    @Transactional
//    public void updateShipped(Long id) {
//        Outbound outbound = checkOutbound(id);
//        Order order = orderRepository.findById(outbound.getOrder().getOrderId())
//                .orElseThrow(() -> new OrderException(ORDER_NOT_FOUND));
//        order.updateShipped();
//        outbound.updateStatus(OutboundStatus.SHIPPED);
//    }

    // 출고 목록 조회
    public List<OutboundReadDto> getOutboundList() {
        return null;
    }

    // 출고 상세 조회
    public OutboundReadDto getOutboundDetails(Long id) {
        return null;
    }

    // 재고 감소 로직
    private void destroyOrDecreaseFromOutbound(Long outboundId, Long taskId) {
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
                            outbound,
                            taskId
                    );
            allHistories.addAll(histories);
        }

        if (!allHistories.isEmpty()) {
            outboundHistoryRepository.saveAll(allHistories);
        }
    }

    // 재고 감소 로직 내부
    private List<OutboundInventoryHistory> decreaseInventoryByFIFO(Long productId, Integer requiredQuantity, Outbound outbound, Long taskId) {
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
            // TODO 재고 소프트 딜리트 구현 -> 재고 0 = 소프트 딜리트
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
                    .taskId(taskId)
                    .status(OutboundInventoryHistoryStatus.PENDING)
                    .build();
            histories.add(history);
            remainingQuantity -= decreaseAmount;
        }

        if (remainingQuantity > 0) {
            throw new InventoryException(INVENTORY_NOT_FOUND);
        }

        return histories;
    }

    // 재고 증가 로직
    private void recoverInventoryFromOutboundHistory(List<OutboundInventoryHistory> histories) {
        if (!histories.isEmpty()) {
            for (OutboundInventoryHistory history : histories) {
                Inventory inventory = history.getInventory();
                inventory.increase(history.getQuantityChanged());

                history.cancel();
            }

            Long taskId = histories.get(0).getTaskId();
            if (taskId != null) {
                Task task = taskRepository.findById(taskId)
                        .orElseThrow(() -> new TaskException(TASK_NOT_FOUND));
                task.cancel("출고서 취소로 인한 작업 취소");
            }
        }
    }

    // 검증 로직들

    private void validateAllHistoriesArePending(List<OutboundInventoryHistory> histories) {
        if (histories.isEmpty()) {
            return;
        }
        boolean hasNonPendingHistory = histories.stream()
                .anyMatch(h -> h.getStatus() != OutboundInventoryHistoryStatus.PENDING);
        if (hasNonPendingHistory) {
            throw new OutboundException(OUTBOUND_HISTORY_ALREADY_PROCESSED);
        }

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

    private Outbound checkOutbound(Long id) {
        return outboundRepository.findById(id)
                .orElseThrow(() -> new OutboundException(OUTBOUND_NOT_FOUND));
    }
}
