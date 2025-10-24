package com.fourweekdays.fourweekdays.tasks.service;

import com.fourweekdays.fourweekdays.inbound.repository.InboundRepository;
import com.fourweekdays.fourweekdays.tasks.factory.InboundTaskFactory;
import com.fourweekdays.fourweekdays.tasks.model.entity.InboundTask;
import com.fourweekdays.fourweekdays.tasks.model.entity.Task;
import com.fourweekdays.fourweekdays.tasks.repository.InboundTaskRepository;
import com.fourweekdays.fourweekdays.tasks.repository.TaskRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class InboundTaskService {

    private final TaskRepository taskRepository;
    private final InboundTaskRepository inboundTaskRepository;
    private final InboundRepository inboundRepository;
    private final InboundTaskFactory inboundTaskFactory;

    public void completeInspection(Long taskId) {
        Task task = taskRepository.findById(taskId)
                .orElseThrow();
        task.complete();

        InboundTask inboundTask = inboundTaskRepository.findById(taskId)
                .orElseThrow();


    }
}
