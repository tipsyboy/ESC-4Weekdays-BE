package com.fourweekdays.fourweekdays.tasks.repository;

import com.fourweekdays.fourweekdays.tasks.model.entity.InboundTask;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InboundTaskRepository extends JpaRepository<InboundTask, Long> {
}
