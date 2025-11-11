package com.fourweekdays.fourweekdays.vendor.repository;

import com.fourweekdays.fourweekdays.inventory.model.dto.request.InventorySearchRequest;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorSearchRequest;
import com.fourweekdays.fourweekdays.vendor.model.dto.response.VendorProductResponse;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface VendorRepositoryCustom {

    Page<Vendor> findAllWithPaging(Pageable pageable);

    Page<VendorProductResponse> searchVendorByProduct(Pageable pageable, VendorSearchRequest request);
}
