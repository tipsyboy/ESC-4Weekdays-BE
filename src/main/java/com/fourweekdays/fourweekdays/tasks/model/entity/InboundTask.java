package com.fourweekdays.fourweekdays.tasks.model.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class InboundTask {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long inboundId;

    @OneToOne
    @JoinColumn(name = "task_id")
    private Task task;

    @Enumerated(EnumType.STRING)
    private InboundWorkType workType; // INSPECTION, PUTAWAY

    @Builder
    public InboundTask(Long inboundId, Task task, InboundWorkType workType) {
        this.inboundId = inboundId;
        this.task = task;
        this.workType = workType;
    }
}
