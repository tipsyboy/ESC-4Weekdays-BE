package com.fourweekdays.fourweekdays.product.repository;

import com.querydsl.core.types.Order;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.ComparableExpressionBase;
import org.springframework.data.domain.Sort;

import java.util.ArrayList;
import java.util.List;

import static com.fourweekdays.fourweekdays.product.domain.QProduct.product;

public final class ProductQuerySortUtils {

    private ProductQuerySortUtils() {
    }

    public static OrderSpecifier<?>[] toOrderSpecifiers(Sort sort) {
        List<OrderSpecifier<?>> orderSpecifiers = new ArrayList<>();

        for (Sort.Order order : sort) {
            Order direction = order.isAscending() ? Order.ASC : Order.DESC;

            switch (order.getProperty()) {
                case "name" -> orderSpecifiers.add(orderBy(direction, product.name));
                case "createdAt" -> orderSpecifiers.add(orderBy(direction, product.createdAt));
                case "updatedAt" -> orderSpecifiers.add(orderBy(direction, product.updatedAt));
                case "productCode" -> orderSpecifiers.add(orderBy(direction, product.productCode));
                case "status" -> orderSpecifiers.add(orderBy(direction, product.status));
                default -> orderSpecifiers.add(orderBy(Order.DESC, product.updatedAt));
            }
        }

        if (orderSpecifiers.isEmpty()) {
            orderSpecifiers.add(orderBy(Order.DESC, product.updatedAt));
        }

        return orderSpecifiers.toArray(new OrderSpecifier[0]);
    }

    private static <T extends Comparable<?>> OrderSpecifier<T> orderBy(Order order, ComparableExpressionBase<T> expression) {
        return new OrderSpecifier<>(order, expression);
    }
}
