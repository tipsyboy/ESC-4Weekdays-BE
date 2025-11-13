package com.fourweekdays.fourweekdays.inbound.repository;

import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface InboundRepositoryCustom {

    Page<Inbound> searchInboundWithProduct(Pageable pageable, String inboundCode, String productName, String managerName, List<Long> vendorIds);
}
