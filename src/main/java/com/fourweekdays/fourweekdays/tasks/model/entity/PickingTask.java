package com.fourweekdays.fourweekdays.tasks.model.entity;

import jakarta.persistence.*;
import lombok.Builder;

public class PickingTask {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long outboundId;

    @OneToOne
    @JoinColumn(name = "task_id")
    private Task task;

    @Builder
    public PickingTask(Long outboundId, Task task) {
        this.outboundId = outboundId;
        this.task = task;
    }
}
