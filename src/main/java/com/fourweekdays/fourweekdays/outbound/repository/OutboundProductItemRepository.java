package com.fourweekdays.fourweekdays.outbound.repository;

import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundProductItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OutboundProductItemRepository extends JpaRepository<OutboundProductItem, Long> {
}
