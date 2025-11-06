package com.fourweekdays.fourweekdays.tasks.repository;

import com.fourweekdays.fourweekdays.tasks.model.entity.PackingTask;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PackingTaskRepository extends JpaRepository<PackingTask, Integer> {
    Optional<PackingTask> findByTaskId(Long taskId);
}
