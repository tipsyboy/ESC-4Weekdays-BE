package com.fourweekdays.fourweekdays.asn.repository;

import com.fourweekdays.fourweekdays.asn.domain.Asn;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AsnRepository extends JpaRepository<Asn, Long>, AsnRepositoryCustom {

    boolean existsByPurchaseOrder(PurchaseOrder purchaseOrder);

    Page<Asn> findByVendorId(Long vendorId, Pageable pageable);
}
