package com.fourweekdays.fourweekdays.purchaseorder.service;

import com.fourweekdays.fourweekdays.purchaseorder.model.dto.request.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.dto.response.PurchaseOrderReadDto;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.fourweekdays.fourweekdays.vendor.repository.VendorRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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

    public PurchaseOrderReadDto findByPurchaseOrderId(Long id) {
        PurchaseOrder purchaseOrder = purchaseOrderRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("해당 발주를 찾을 수 없습니다. id=" + id));

        return PurchaseOrderReadDto.toDto(purchaseOrder);
    }

    public List<PurchaseOrderReadDto> findAll() {
        return purchaseOrderRepository.findAll().stream()
                .map(PurchaseOrderReadDto::toDto)
                .toList();
    }
}
