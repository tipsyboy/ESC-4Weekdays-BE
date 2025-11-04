package com.fourweekdays.fourweekdays.tasks.repository;

import com.fourweekdays.fourweekdays.tasks.model.entity.PickingTask;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PickingTaskRepository extends JpaRepository<PickingTask, Long> {
    Optional<PickingTask> findByTaskId(Long taskId);
}
