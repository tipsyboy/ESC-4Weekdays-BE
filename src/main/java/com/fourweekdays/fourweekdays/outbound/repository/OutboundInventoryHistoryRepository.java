package com.fourweekdays.fourweekdays.outbound.repository;

import com.fourweekdays.fourweekdays.outbound.model.entity.OutboundInventoryHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OutboundInventoryHistoryRepository extends JpaRepository<OutboundInventoryHistory, Long> {

    @Query("SELECT h FROM OutboundInventoryHistory h " +
            "JOIN FETCH h.inventory i " +
            "JOIN FETCH i.product " +
            "JOIN FETCH i.location " +
            "WHERE h.outbound.id = :outboundId")
    List<OutboundInventoryHistory> findAllByOutboundIdWithInventory(@Param("outboundId") Long outboundId);
}
