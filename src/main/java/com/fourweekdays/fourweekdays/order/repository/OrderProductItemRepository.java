package com.fourweekdays.fourweekdays.order.repository;

import com.fourweekdays.fourweekdays.order.model.entity.OrderProductItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderProductItemRepository extends JpaRepository<OrderProductItem, Long> {
}
