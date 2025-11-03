package com.fourweekdays.fourweekdays.tasks.repository;

import com.fourweekdays.fourweekdays.tasks.model.entity.PickingTask;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PickingTaskRepository extends JpaRepository<PickingTask, Long> {
}
