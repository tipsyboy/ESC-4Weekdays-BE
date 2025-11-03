package com.fourweekdays.fourweekdays.outbound.repository;

import com.fourweekdays.fourweekdays.order.model.entity.Order;
import com.fourweekdays.fourweekdays.outbound.model.entity.Outbound;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface OutboundRepository extends JpaRepository<Outbound, Long> {
    boolean existsByOrder(Order order);

    @Query("SELECT o FROM Outbound o " +
            "JOIN FETCH o.items i " +
            "JOIN FETCH i.product " +
            "WHERE o.id = :outboundId")
    Optional<Outbound> findByIdWithItemsAndProduct(@Param("outboundId") Long outboundId);
}
