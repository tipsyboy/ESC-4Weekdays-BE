package com.fourweekdays.fourweekdays.tasks.factory;

import com.fourweekdays.fourweekdays.tasks.model.entity.*;
import com.fourweekdays.fourweekdays.tasks.repository.InboundTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class InboundTaskFactory {

    private final TaskRepository taskRepository;
    private final InboundTaskRepository inboundTaskRepository;

    public Long createInspectionTask(Long inboundId) {
        Task task = createTask(TaskCategory.INBOUND);
        InboundTask inboundTask = createInboundTask(task, InboundWorkType.INSPECTION, inboundId);
        return task.getId();
    }

    private Task createTask(TaskCategory category) {
        Task task = Task.builder()
                .category(category)
                .status(TaskStatus.PENDING)
                .build();
        return taskRepository.save(task);
    }

    private InboundTask createInboundTask(Task task, InboundWorkType workType, Long inboundId) {
        InboundTask inboundTask = InboundTask.builder()
                .task(task)
                .workType(workType)
                .inboundId(inboundId)
                .build();
        return inboundTaskRepository.save(inboundTask);
    }
}
