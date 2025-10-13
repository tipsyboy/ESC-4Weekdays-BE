package com.fourweekdays.fourweekdays.purchaseorder.service;

import com.fourweekdays.fourweekdays.purchaseorder.model.dto.PurchaseOrderCreateDto;
import com.fourweekdays.fourweekdays.purchaseorder.repository.PurchaseOrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly = true)
@RequiredArgsConstructor
@Service
public class PurchaseOrderService {

    private final PurchaseOrderRepository purchaseOrderRepository;

    @Transactional
    public Long create(PurchaseOrderCreateDto requestDto) {

    }
}
