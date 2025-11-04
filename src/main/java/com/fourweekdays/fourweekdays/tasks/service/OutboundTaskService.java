package com.fourweekdays.fourweekdays.tasks.service;

import com.fourweekdays.fourweekdays.outbound.model.entity.Outbound;
import com.fourweekdays.fourweekdays.outbound.repository.OutboundRepository;
import com.fourweekdays.fourweekdays.tasks.exception.TaskException;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskAssignRequest;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskPickingCompleteRequest;
import com.fourweekdays.fourweekdays.tasks.model.dto.request.TaskPickingWorderAssignRequest;
import com.fourweekdays.fourweekdays.tasks.model.entity.PickingTask;
import com.fourweekdays.fourweekdays.tasks.model.entity.Task;
import com.fourweekdays.fourweekdays.tasks.model.entity.TaskStatus;
import com.fourweekdays.fourweekdays.tasks.repository.PickingTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.PutawayTaskRepository;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.PICKING_TASK_NOT_FOUND;
import static com.fourweekdays.fourweekdays.tasks.exception.TaskExceptionType.TASK_CANNOT_ASSIGN;

@Service
@RequiredArgsConstructor
public class OutboundTaskService {

    private final TaskService taskService;
    private final PickingTaskRepository pickingTaskRepository;
    private final OutboundRepository outboundRepository;

    // 피킹 작업자 할당
    @Transactional
    public void assignWorker(Long taskId, TaskPickingWorderAssignRequest request) {
        // TODO 동시성 이슈 해결
        PickingTask pickingTask = pickingTaskRepository.findByTaskId(taskId)
                .orElseThrow(() -> new TaskException(PICKING_TASK_NOT_FOUND));

        Task task = pickingTask.getTask();
        if (task.getStatus() != TaskStatus.PENDING) {
            throw new TaskException(TASK_CANNOT_ASSIGN);
        }

        outboundRepository.findById(pickingTask.getOutboundId())
                .orElseThrow(() -> new TaskException(PICKING_TASK_NOT_FOUND));

        TaskAssignRequest assignRequest = new TaskAssignRequest(
                request.worderId(),
                request.note()
        );
        taskService.assignWorker(taskId, assignRequest);
    }

    // 피킹 완료
    public void completePicking(Long taskId, @Valid TaskPickingCompleteRequest request) {
        PickingTask pickingTask = pickingTaskRepository.findByTaskId(taskId)
                .orElseThrow(() -> new TaskException(PICKING_TASK_NOT_FOUND));


    }
}
