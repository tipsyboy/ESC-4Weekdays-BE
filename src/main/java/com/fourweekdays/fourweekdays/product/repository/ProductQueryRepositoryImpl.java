package com.fourweekdays.fourweekdays.product.repository;

import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.product.domain.ProductStatus;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.fourweekdays.fourweekdays.product.domain.QProduct.product;
import static com.fourweekdays.fourweekdays.vendor.domain.QVendor.vendor;

@Repository
@RequiredArgsConstructor
public class ProductQueryRepositoryImpl implements ProductQueryRepository {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<Product> search(
            String vendorName,
            String productCode,
            String productName,
            String category,
            ProductStatus status,
            Pageable pageable
    ) {
        List<Product> content = queryFactory
                .selectFrom(product)
                .join(product.vendor, vendor).fetchJoin()
                .where(
                        containsVendorName(vendorName),
                        containsProductCode(productCode),
                        containsProductName(productName),
                        containsCategory(category),
                        eqStatus(status)
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(ProductQuerySortUtils.toOrderSpecifiers(pageable.getSort()))
                .fetch();

        return PageableExecutionUtils.getPage(
                content,
                pageable,
                () -> {
                    Long count = queryFactory
                            .select(product.count())
                            .from(product)
                            .join(product.vendor, vendor)
                            .where(
                                    containsVendorName(vendorName),
                                    containsProductCode(productCode),
                                    containsProductName(productName),
                                    containsCategory(category),
                                    eqStatus(status)
                            )
                            .fetchOne();
                    return count != null ? count : 0L;
                }
        );
    }

    private BooleanExpression containsVendorName(String vendorName) {
        return hasText(vendorName) ? vendor.name.containsIgnoreCase(vendorName.trim()) : null;
    }

    private BooleanExpression containsProductCode(String productCode) {
        return hasText(productCode) ? product.productCode.containsIgnoreCase(productCode.trim()) : null;
    }

    private BooleanExpression containsProductName(String productName) {
        return hasText(productName) ? product.name.containsIgnoreCase(productName.trim()) : null;
    }

    private BooleanExpression containsCategory(String category) {
        return hasText(category) ? product.category.containsIgnoreCase(category.trim()) : null;
    }

    private BooleanExpression eqStatus(ProductStatus status) {
        return status != null ? product.status.eq(status) : null;
    }

    private boolean hasText(String value) {
        return value != null && !value.isBlank();
    }
}
