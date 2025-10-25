package com.fourweekdays.fourweekdays.tasks.factory;

import com.fourweekdays.fourweekdays.inbound.exception.InboundException;
import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.tasks.model.entity.*;
import com.fourweekdays.fourweekdays.tasks.repository.InspectionTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import static com.fourweekdays.fourweekdays.inbound.exception.InboundExceptionType.INBOUND_NOT_FOUND;

@RequiredArgsConstructor
@Component
public class InboundTaskFactory {

    private final TaskRepository taskRepository;
    private final InspectionTaskRepository inspectionTaskRepository;
    private final InboundRepository inboundRepository;

    @Transactional
    public Long createInspectionTask(Long inboundId) {
        Inbound inbound = inboundRepository.findById(inboundId)
                .orElseThrow(() -> new InboundException(INBOUND_NOT_FOUND));

        Task task = createTask(TaskCategory.INSPECTION, inboundId);
        InspectionTask inspectionTask = createInboundTask(task, inboundId);

        inspectionTaskRepository.save(inspectionTask);
        return task.getId();
    }

    private Task createTask(TaskCategory category, Long referenceId) {
        Task task = Task.builder()
                .category(category)
                .status(TaskStatus.PENDING)
                .referenceId(referenceId)
                .build();
        return taskRepository.save(task);
    }

    private InspectionTask createInboundTask(Task task, Long inboundId) {
        InspectionTask inspectionTask = InspectionTask.builder()
                .task(task)
                .inboundId(inboundId)
                .build();
        return inspectionTaskRepository.save(inspectionTask);
    }

    public void createPutawayTask(Long inboundId) {

    }
}
