package com.fourweekdays.fourweekdays.tasks.repository;

import com.fourweekdays.fourweekdays.tasks.model.entity.ShipmentTask;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ShipmentTaskRepository extends JpaRepository<ShipmentTask, Integer> {
    Optional<ShipmentTask> findByTaskId(Long taskId);

    Optional<ShipmentTask> findByOutboundId(Long outboundId);
}
