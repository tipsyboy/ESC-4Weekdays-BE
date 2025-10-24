package com.fourweekdays.fourweekdays.tasks.controller;

import com.fourweekdays.fourweekdays.tasks.model.dto.request.AssignRequest;
import com.fourweekdays.fourweekdays.tasks.service.TaskService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/tasks")
@RequiredArgsConstructor
@RestController
public class TaskController {

    private final TaskService taskService;

    @PostMapping("/{taskId}/assign")
    public ResponseEntity<Void> assignWorker(@PathVariable Long taskId,
                                             @RequestBody AssignRequest request) {
        taskService.assignWorker(taskId, request);
        return ResponseEntity.ok().build();
    }
}
