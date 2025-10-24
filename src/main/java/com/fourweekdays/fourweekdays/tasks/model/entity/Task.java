package com.fourweekdays.fourweekdays.tasks.model.entity;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter @NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Task extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TaskCategory category; // INBOUND, OUTBOUND, RELOCATION

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private TaskStatus status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member worker;

    private LocalDateTime assignedAt;
    private LocalDateTime completedAt;

    @Builder
    public Task(TaskCategory category, TaskStatus status) {
        this.category = category;
        this.status = status;
    }

    // 공통 비즈니스 로직
    public void assignTo(Member worker) { }
    public void start() {  }
    public void complete() {  }
}