package com.fourweekdays.fourweekdays.vendor.repository;

import com.fourweekdays.fourweekdays.vendor.dto.VendorSearchCondition;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface VendorRepositoryCustom {

    Page<Vendor> search(Pageable pageable, VendorSearchCondition condition);
}
