package com.fourweekdays.fourweekdays.asn.repository;

import com.fourweekdays.fourweekdays.asn.model.entity.ASN;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ASNRepository extends JpaRepository<ASN, Long>, ASNRepositoryCustom {
}
}

