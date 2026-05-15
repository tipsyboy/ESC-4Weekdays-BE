package com.fourweekdays.fourweekdays.inventory.repository;

import com.fourweekdays.fourweekdays.inventory.domain.Inventory;
import com.fourweekdays.fourweekdays.location.domain.Location;
import com.fourweekdays.fourweekdays.product.domain.Product;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import jakarta.persistence.LockModeType;

public interface InventoryRepository extends JpaRepository<Inventory, Long> {

    @Query("""
            select i from Inventory i
            join fetch i.product p
            join fetch p.vendor
            join fetch i.location
            left join fetch i.lastInbound
            order by i.id desc
            """)
    List<Inventory> findAllByOrderByIdDesc();

    @Query("""
            select i from Inventory i
            join fetch i.product p
            join fetch p.vendor
            join fetch i.location
            left join fetch i.lastInbound
            where p.id = :productId
            order by i.id desc
            """)
    List<Inventory> findAllByProductIdOrderByIdDesc(@Param("productId") Long productId);

    Optional<Inventory> findByProductAndLocationAndLotNumber(Product product, Location location, String lotNumber);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("""
            select i from Inventory i
            where i.product.id = :productId
              and i.location.id = :locationId
              and i.lotNumber = :lotNumber
            """)
    Optional<Inventory> findByProductAndLocationAndLotWithLock(
            @Param("productId") Long productId,
            @Param("locationId") Long locationId,
            @Param("lotNumber") String lotNumber
    );

    @Query("select i from Inventory i where i.product.id = :productId and i.quantity > 0")
    List<Inventory> findByProductId(@Param("productId") Long productId);

    @Query("select i from Inventory i where i.location.id = :locationId and i.quantity > 0")
    List<Inventory> findByLocationId(@Param("locationId") Long locationId);

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("""
            select i from Inventory i
            join fetch i.product
            join fetch i.location
            where i.product.id = :productId
              and i.quantity > 0
            order by i.lotNumber asc
            """)
    List<Inventory> findAllByProductIdOrderByLotNumberAsc(@Param("productId") Long productId);
}
