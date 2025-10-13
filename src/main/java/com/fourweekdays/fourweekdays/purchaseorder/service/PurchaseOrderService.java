package com.fourweekdays.fourweekdays.purchaseorder.service;

import com.fourweekdays.fourweekdays.purchaseorder.model.dto.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.Vendor;
import com.fourweekdays.fourweekdays.vendor.VendorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
@RequiredArgsConstructor
@Service
public class PurchaseOrderService {

    private final PurchaseOrderRepository purchaseOrderRepository;
    private final VendorRepository vendorRepository;

    @Transactional
    public Long create(PurchaseOrderCreateDto requestDto) {
        Vendor vendor = vendorRepository.findById(requestDto.getVendorId())
                .orElseThrow(() -> new IllegalArgumentException("공급 업체를 찾을 수 없습니다."));

        PurchaseOrder purchaseOrder = requestDto.toEntity(vendor);
        return purchaseOrderRepository.save(purchaseOrder).getId();
    }


}
