package com.fourweekdays.fourweekdays.tasks.service;

import com.fourweekdays.fourweekdays.inbound.exception.InboundException;
import com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType;
import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundStatusUpdateRequest;
import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.inbound.model.entity.InboundProduct;
import com.fourweekdays.fourweekdays.inbound.model.entity.InboundStatus;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.inbound.service.InboundService;
import com.fourweekdays.fourweekdays.inventory.service.InventoryService;
import com.fourweekdays.fourweekdays.location.exception.LocationException;
import com.fourweekdays.fourweekdays.location.exception.LocationExceptionType;
import com.fourweekdays.fourweekdays.location.model.entity.Location;
import com.fourweekdays.fourweekdays.location.repository.LocationRepository;
import com.fourweekdays.fourweekdays.location.service.LocationService;
import com.fourweekdays.fourweekdays.tasks.exception.TaskException;
import com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType;
import com.fourweekdays.fourweekdays.tasks.factory.InboundTaskFactory;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskCompleteRequest;
import com.fourweekdays.fourweekdays.tasks.model.entity.InspectionTask;
import com.fourweekdays.fourweekdays.tasks.model.entity.PutawayTask;
import com.fourweekdays.fourweekdays.tasks.repository.InspectionTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.PutawayTaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType.INBOUND_NOT_FOUND;
import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.INSPECTION_TASK_NOT_FOUND;
import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.PUTAWAY_TASK_NOT_FOUND;

@RequiredArgsConstructor
@Service
public class InboundTaskService {

    private final TaskService taskService;
    private final InspectionTaskRepository inspectionTaskRepository;
    private final InboundTaskFactory inboundTaskFactory;
    private final InboundService inboundService;
    private final PutawayTaskRepository putawayTaskRepository;
    private final InboundRepository inboundRepository;
    private final InventoryService inventoryService;
    private final LocationRepository locationRepository;

    @Transactional
    public void completeInspection(Long taskId, TaskCompleteRequest request) {
        taskService.completeTask(taskId, request);

        InspectionTask inspectionTask = inspectionTaskRepository.findByTaskId(taskId)
                .orElseThrow(() -> new TaskException(INSPECTION_TASK_NOT_FOUND));

        // TODO: status 업데이트 구문을 dto가 아닌 방식도 생각해보자.
        inboundService.updateInboundStatus(inspectionTask.getInboundId(), new InboundStatusUpdateRequest(InboundStatus.PUTAWAY));

        inboundTaskFactory.createPutawayTask(inspectionTask.getInboundId());
    }

    @Transactional
    public void completePutaway(Long taskId, TaskCompleteRequest request) {
        // TODO: 적치 작업이 완료되면 재고 생성 트리거가 발생해야 한다.

        taskService.completeTask(taskId, request);

        PutawayTask putawayTask = putawayTaskRepository.findByTaskId(taskId)
                .orElseThrow(() -> new TaskException(PUTAWAY_TASK_NOT_FOUND));

        Inbound inbound = inboundRepository.findById(putawayTask.getInboundId())
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));

        int totalQuantity = inbound.getProducts().stream()
                .mapToInt(InboundProduct::getReceivedQuantity)
                .sum();

        // TODO: 작업자가 아니고 관리자가 할당할 때 위치 지정해줘야 할거 같은데
        Location location = locationRepository.findByLocationCode("Mock-Data-Location")
                .orElseThrow(() -> new LocationException(LocationExceptionType.LOCATION_NOT_FOUND));
        location.validateForPutaway(inbound.getPurchaseOrder().getVendor().getId(), totalQuantity);

        for (InboundProduct inboundProduct : inbound.getProducts()) {
            inventoryService.createOrIncreaseInventory(
                    inboundProduct.getProduct().getId(),
                    location.getId(),
                    inboundProduct.getLotNumber(),
                    inboundProduct.getReceivedQuantity(),
                    inbound.getId()
            );
        }

        // TODO: status 업데이트 구문을 dto가 아닌 방식도 생각해보자.
        inboundService.updateInboundStatus(putawayTask.getInboundId(), new InboundStatusUpdateRequest(InboundStatus.COMPLETED));
    }
}