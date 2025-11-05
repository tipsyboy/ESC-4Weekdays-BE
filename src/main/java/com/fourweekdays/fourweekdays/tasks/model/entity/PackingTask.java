package com.fourweekdays.fourweekdays.tasks.model.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
public class PackingTask {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long outboundId;

    @OneToOne
    @JoinColumn(name = "task_id")
    private Task task;

    @Builder
    public PackingTask(Long outboundId, Task task) {
        this.outboundId = outboundId;
        this.task = task;
    }
}
