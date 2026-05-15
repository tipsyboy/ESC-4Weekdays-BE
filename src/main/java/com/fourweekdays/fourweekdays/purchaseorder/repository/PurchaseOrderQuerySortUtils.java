package com.fourweekdays.fourweekdays.purchaseorder.repository;

import static com.fourweekdays.fourweekdays.purchaseorder.domain.QPurchaseOrder.purchaseOrder;
import static com.fourweekdays.fourweekdays.vendor.domain.QVendor.vendor;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import java.util.ArrayList;
import java.util.List;
import org.springframework.data.domain.Sort;

public final class PurchaseOrderQuerySortUtils {

    private PurchaseOrderQuerySortUtils() {
    }

    public static OrderSpecifier<?>[] toOrderSpecifiers(Sort sort) {
        List<OrderSpecifier<?>> orderSpecifiers = new ArrayList<>();

        for (Sort.Order order : sort) {
            Order direction = order.isAscending() ? Order.ASC : Order.DESC;

            switch (order.getProperty()) {
                case "purchaseOrderNumber" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.purchaseOrderNumber));
                case "vendorName" -> orderSpecifiers.add(new OrderSpecifier<>(direction, vendor.name));
                case "requesterName" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.requesterName));
                case "approverName" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.approverName));
                case "requestedAt" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.requestedAt));
                case "approvedAt" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.approvedAt));
                case "orderedAt" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.orderedAt));
                case "expectedInboundDate" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.expectedInboundDate));
                case "status" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.status));
                case "createdAt" -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.createdAt));
                default -> orderSpecifiers.add(new OrderSpecifier<>(direction, purchaseOrder.updatedAt));
            }
        }

        if (orderSpecifiers.isEmpty()) {
            orderSpecifiers.add(purchaseOrder.updatedAt.desc());
        }

        orderSpecifiers.add(purchaseOrder.id.desc());
        return orderSpecifiers.toArray(OrderSpecifier[]::new);
    }
}
