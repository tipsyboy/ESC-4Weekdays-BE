package com.fourweekdays.fourweekdays.order.repository;

import com.fourweekdays.fourweekdays.order.model.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
