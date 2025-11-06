package com.fourweekdays.fourweekdays.tasks.factory;

import com.fourweekdays.fourweekdays.outbound.exception.OutboundException;
import com.fourweekdays.fourweekdays.outbound.repository.OutboundRepository;
import com.fourweekdays.fourweekdays.tasks.model.entity.*;
import com.fourweekdays.fourweekdays.tasks.repository.PackingTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.PickingTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.ShipmentTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.outbound.exception.OutboundExceptionType.OUTBOUND_NOT_FOUND;

@RequiredArgsConstructor
@Component
public class OutboundTaskFactory {

    private final TaskRepository taskRepository;
    private final OutboundRepository outboundRepository;
    private final PickingTaskRepository pickingTaskRepository;
    private final PackingTaskRepository packingTaskRepository;
    private final ShipmentTaskRepository shipmentTaskRepository;

    @Transactional
    public Long createPickingTask(Long outboundId) {
        Task task = createTask(TaskCategory.PICKING, outboundId);
        createPickingTaskDetail(task, outboundId);
        return task.getId();
    }

//    @Transactional
//    public Long createInspectionTask(Long outboundId) {
//        Outbound outbound = outboundRepository.findById(outboundId)
//                .orElseThrow(() -> new OutboundException(OUTBOUND_NOT_FOUND));
//
//        Task task = createTask(TaskCategory.INSPECTION, outboundId);
//        return task.getId();
//    }

    @Transactional
    public Long createPackingTask(Long outboundId) {
        outboundRepository.findById(outboundId)
                .orElseThrow(() -> new OutboundException(OUTBOUND_NOT_FOUND));
        Task task = createTask(TaskCategory.PACKING, outboundId);
        createPackingTaskDetail(task, outboundId);
        return task.getId();
    }

    @Transactional
    public Long createShipment(Long outboundId) {
        outboundRepository.findById(outboundId)
                .orElseThrow(() -> new OutboundException(OUTBOUND_NOT_FOUND));
        Task task = createTask(TaskCategory.SHIPMENT, outboundId);
        createShipmentTaskDetail(task, outboundId);
        return task.getId();
    }

    private Task createTask(TaskCategory taskCategory, Long outboundId) {
        Task task = Task.builder()
                .category(taskCategory)
                .status(TaskStatus.PENDING)
                .referenceId(outboundId)
                .build();
        return taskRepository.save(task);
    }

    private PickingTask createPickingTaskDetail(Task task, Long outboundId) {
        PickingTask pickingTask = PickingTask.builder()
                .task(task)
                .outboundId(outboundId)
                .build();
        return pickingTaskRepository.save(pickingTask);
    }

    private PackingTask createPackingTaskDetail(Task task, Long outboundId) {
        PackingTask packingTask = PackingTask.builder()
                .task(task)
                .outboundId(outboundId)
                .build();
        return packingTaskRepository.save(packingTask);
    }

    private ShipmentTask createShipmentTaskDetail(Task task, Long outboundId) {
        ShipmentTask shipmentTask = ShipmentTask.builder()
                .task(task)
                .outboundId(outboundId)
                .build();
        return shipmentTaskRepository.save(shipmentTask);
    }
}
