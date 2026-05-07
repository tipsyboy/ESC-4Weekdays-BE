package com.fourweekdays.fourweekdays.asn.repository;

import com.fourweekdays.fourweekdays.asn.domain.Asn;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AsnRepository extends JpaRepository<Asn, Long>, AsnSummaryRepository {

    List<Asn> findAllByOrderByIdDesc();

    @Override
    Page<Asn> findAll(Pageable pageable);

    List<Asn> findAllByPurchaseOrderVendorIdOrderByIdDesc(Long vendorId);

    Page<Asn> findAllByPurchaseOrderVendorIdOrderByIdDesc(Long vendorId, Pageable pageable);

    Optional<Asn> findByPurchaseOrderId(Long purchaseOrderId);

    @Override
    Optional<Asn> findById(Long id);

    boolean existsByPurchaseOrderId(Long purchaseOrderId);
}
