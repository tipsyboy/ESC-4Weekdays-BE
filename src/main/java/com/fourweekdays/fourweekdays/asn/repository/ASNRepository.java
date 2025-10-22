package com.fourweekdays.fourweekdays.asn.repository;

import com.fourweekdays.fourweekdays.asn.model.entity.ASN;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ASNRepository extends JpaRepository<ASN, Long> {

    boolean existsByAsnCode(String asnCode);
}

