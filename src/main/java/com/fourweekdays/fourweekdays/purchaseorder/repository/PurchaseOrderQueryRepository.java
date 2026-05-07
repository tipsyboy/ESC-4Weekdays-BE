package com.fourweekdays.fourweekdays.purchaseorder.repository;

import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrderStatus;
import java.time.LocalDate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface PurchaseOrderQueryRepository {
    Page<PurchaseOrder> search(
            String vendorName,
            String requesterName,
            PurchaseOrderStatus status,
            LocalDate expectedInboundDate,
            String approverName,
            String purchaseOrderNumber,
            String memoKeyword,
            Pageable pageable
    );
}
