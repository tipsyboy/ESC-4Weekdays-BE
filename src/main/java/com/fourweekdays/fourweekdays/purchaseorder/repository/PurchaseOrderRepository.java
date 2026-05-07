package com.fourweekdays.fourweekdays.purchaseorder.repository;

import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PurchaseOrderRepository extends JpaRepository<PurchaseOrder, Long>, PurchaseOrderRepositoryCustom, PurchaseOrderQueryRepository {
    Optional<PurchaseOrder> findByOrderCode(String orderCode);

    @EntityGraph(attributePaths = {"vendor", "products", "products.product"})
    List<PurchaseOrder> findByVendorId(Long vendorId);

    @Override
    @EntityGraph(attributePaths = {"vendor", "products", "products.product"})
    Optional<PurchaseOrder> findById(Long id);
}
