package com.fourweekdays.fourweekdays.tasks.service;

import com.fourweekdays.fourweekdays.inbound.model.dto.request.InboundStatusUpdateRequest;
import com.fourweekdays.fourweekdays.inbound.model.entity.InboundStatus;
import com.fourweekdays.fourweekdays.inbound.service.InboundService;
import com.fourweekdays.fourweekdays.tasks.exception.TaskException;
import com.fourweekdays.fourweekdays.tasks.factory.InboundTaskFactory;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskCompleteRequest;
import com.fourweekdays.fourweekdays.tasks.model.entity.InspectionTask;
import com.fourweekdays.fourweekdays.tasks.repository.InspectionTaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.INSPECTION_TASK_NOT_FOUND;

@RequiredArgsConstructor
@Service
public class InboundTaskService {

    private final TaskService taskService;
    private final InspectionTaskRepository inspectionTaskRepository;
    private final InboundTaskFactory inboundTaskFactory;
    private final InboundService inboundService;

    @Transactional
    public void completeInspection(Long taskId, TaskCompleteRequest request) {
        taskService.completeTask(taskId, request);

        InspectionTask inspectionTask = inspectionTaskRepository.findByTaskId(taskId)
                .orElseThrow(() -> new TaskException(INSPECTION_TASK_NOT_FOUND));

        inboundService.updateInboundStatus(inspectionTask.getInboundId(), new InboundStatusUpdateRequest(InboundStatus.PUTAWAY));

        // TODO: 검수 완료후 적치 작업 자동 생성
        inboundTaskFactory.createPutawayTask(inspectionTask.getInboundId());
    }
}