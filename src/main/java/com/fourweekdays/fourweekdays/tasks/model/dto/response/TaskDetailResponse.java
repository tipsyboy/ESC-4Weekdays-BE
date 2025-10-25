package com.fourweekdays.fourweekdays.tasks.model.dto.response;

import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.tasks.model.entity.InspectionTask;
import com.fourweekdays.fourweekdays.tasks.model.entity.Task;
import com.fourweekdays.fourweekdays.tasks.model.entity.TaskCategory;
import com.fourweekdays.fourweekdays.tasks.model.entity.TaskStatus;

import java.time.LocalDateTime;

public record TaskDetailResponse(
        Long taskId,
        TaskCategory category,
        TaskStatus status,
        String workerName,
        String note,
        LocalDateTime assignedAt,
        LocalDateTime startedAt,
        LocalDateTime completedAt,

        Long referenceId,
        String referenceCode
//        String referenceName, // 거래처명
//        Integer totalQuantity
) {
    public static TaskDetailResponse ofInspection(Task task, InspectionTask detail, Inbound inbound) {
        return new TaskDetailResponse(
                task.getId(),
                task.getCategory(),
                task.getStatus(),
                task.getWorker() != null ? task.getWorker().getName() : null,
                task.getNote(),
                task.getAssignedAt(),
                task.getStartedAt(),
                task.getCompletedAt(),
                inbound.getId(),
                inbound.getInboundCode()
        );
    }
}