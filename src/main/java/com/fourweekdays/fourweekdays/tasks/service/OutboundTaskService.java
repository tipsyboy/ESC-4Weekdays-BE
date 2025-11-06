package com.fourweekdays.fourweekdays.tasks.service;

import com.fourweekdays.fourweekdays.outbound.repository.OutboundRepository;
import com.fourweekdays.fourweekdays.outbound.service.OutboundService;
import com.fourweekdays.fourweekdays.tasks.controller.TaskPackingCompleteRequest;
import com.fourweekdays.fourweekdays.tasks.exception.TaskException;
import com.fourweekdays.fourweekdays.tasks.factory.OutboundTaskFactory;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.*;
import com.fourweekdays.fourweekdays.tasks.model.entity.*;
import com.fourweekdays.fourweekdays.tasks.repository.PackingTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.PickingTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.ShipmentTaskRepository;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.*;

@Service
@RequiredArgsConstructor
public class OutboundTaskService {

    private final TaskService taskService;
    private final PickingTaskRepository pickingTaskRepository;
//    private final OutboundRepository outboundRepository;
    private final OutboundService outboundService;
    private final OutboundTaskFactory outboundTaskFactory;
    private final PackingTaskRepository packingTaskRepository;
    private final ShipmentTaskRepository shipmentTaskRepository;

//    // 피킹 작업자 할당
//    @Transactional
//    public void assignWorker(Long taskId, TaskPickingWorderAssignRequest request) {
//        PickingTask pickingTask = pickingTaskRepository.findByTaskId(taskId)
//                .orElseThrow(() -> new TaskException(PICKING_TASK_NOT_FOUND));
//
//        Task task = pickingTask.getTask();
//        if (task.getStatus() != TaskStatus.PENDING) {
//            throw new TaskException(TASK_CANNOT_ASSIGN);
//        }
//
//        outboundRepository.findById(pickingTask.getOutboundId())
//                .orElseThrow(() -> new TaskException(PICKING_TASK_NOT_FOUND));
//
//        TaskAssignRequest assignRequest = new TaskAssignRequest(
//                request.worderId(),
//                request.note()
//        );
//        taskService.assignWorker(taskId, assignRequest);
//    }

    // 피킹 완료
    @Transactional
    public void completePicking(Long taskId, @Valid TaskPickingCompleteRequest request) {
        // 피킹 테스트 완료 처리
        PickingTask pickingTask = pickingTaskRepository.findByTaskId(taskId)
                .orElseThrow(() -> new TaskException(PICKING_TASK_NOT_FOUND));

        // 작업 완료 처리
        TaskCompleteRequest taskCompleteRequest = new TaskCompleteRequest(request.note());
        taskService.completeTask(pickingTask.getTask().getId(), taskCompleteRequest);

        // 출고 상태 변경
        outboundService.updatePicking(pickingTask.getOutboundId());

        // 패킹 작업 생성
        outboundTaskFactory.createPackingTask(pickingTask.getOutboundId());
    }

    // 패킹 완료
    @Transactional
    public void completePacking(Long taskId, TaskPackingCompleteRequest request) {
        PackingTask packingTask = packingTaskRepository.findByTaskId(taskId)
                .orElseThrow(() -> new TaskException(PACKING_TASK_NOT_FOUND));

        TaskCompleteRequest taskCompleteRequest = new TaskCompleteRequest(request.note());
        taskService.completeTask(packingTask.getTask().getId(), taskCompleteRequest);

        outboundService.updatePacking(packingTask.getOutboundId());

        // 출하를 만들어
        outboundTaskFactory.createShipment(packingTask.getOutboundId());
    }

    // 송하인 배정 (송하인 = 운송 계약에서, 물품의 운송을 위탁하는 사람.)
    @Transactional
    public void assignShipper(Long taskId, @Valid TaskShipmentAssignShipperRequest request) {
        ShipmentTask shipmentTask = shipmentTaskRepository.findByTaskId(taskId)
                .orElseThrow(() -> new TaskException(SHIPMENT_TASK_NOT_FOUND));

        Task task = shipmentTask.getTask();
        if (task.getStatus() != TaskStatus.PENDING) {
            throw new TaskException(TASK_CANNOT_ASSIGN);
        }

        // 송하인 배정
        shipmentTask.assignShipper(request.shipper());
    }
}
