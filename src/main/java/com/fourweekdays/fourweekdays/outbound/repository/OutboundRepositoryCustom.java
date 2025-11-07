package com.fourweekdays.fourweekdays.outbound.repository;

import com.fourweekdays.fourweekdays.outbound.model.entity.Outbound;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface OutboundRepositoryCustom {
    Page<Outbound> findAllWithPaging(Pageable pageable);
}
