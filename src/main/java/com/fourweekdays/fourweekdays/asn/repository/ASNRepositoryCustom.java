package com.fourweekdays.fourweekdays.asn.repository;


import com.fourweekdays.fourweekdays.asn.model.entity.ASN;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ASNRepositoryCustom {

    Page<ASN> findAllWithPaging(Pageable pageable);
}
