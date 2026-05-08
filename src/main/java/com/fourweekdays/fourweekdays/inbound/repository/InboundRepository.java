package com.fourweekdays.fourweekdays.inbound.repository;

import com.fourweekdays.fourweekdays.inbound.domain.Inbound;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InboundRepository extends JpaRepository<Inbound, Long>, InboundRepositoryCustom {

    List<Inbound> findAllByOrderByIdDesc();

    @Override
    Page<Inbound> findAll(Pageable pageable);

    Page<Inbound> findByPurchaseOrderVendorId(Long vendorId, Pageable pageable);

    Optional<Inbound> findByAsnId(Long asnId);

    boolean existsByAsnId(Long asnId);
}
