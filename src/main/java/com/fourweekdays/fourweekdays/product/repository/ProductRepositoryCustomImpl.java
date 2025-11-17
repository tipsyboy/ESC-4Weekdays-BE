package com.fourweekdays.fourweekdays.product.repository;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import java.util.List;

import static com.fourweekdays.fourweekdays.product.model.entity.QProduct.product;

@RequiredArgsConstructor
public class ProductRepositoryCustomImpl implements ProductRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<Product> findAllWithPaging(Pageable pageable) {
        List<Product> products = queryFactory
                .selectFrom(product)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(product.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .select(product.count())
                .from(product)
                .fetchOne();

        return new PageImpl<>(products, pageable, total);
    }

    public Page<Product> searchProducts(Pageable pageable, ProductSearchRequest request) {
        List<Product> results = queryFactory
                .selectFrom(product)
                .leftJoin(product.vendor).fetchJoin()
                .where(
                        productCodeEq(request.productCode()),
                        productNameLike(request.productName()),
                        productStatusEq(request.status()),
                        vendorNameContains(request.vendorName())
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(product.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .select(product.count())
                .from(product)
                .leftJoin(product.vendor)
                .where(
                        productCodeEq(request.productCode()),
                        productNameLike(request.productName()),
                        productStatusEq(request.status()),
                        vendorNameContains(request.vendorName())
                )
                .fetchOne();

        return new PageImpl<>(results, pageable, total != null ? total : 0);
    }

    private BooleanExpression productCodeEq(String productCode) {
        return StringUtils.hasText(productCode) ? product.productCode.eq(productCode) : null;
    }

    private BooleanExpression productNameLike(String productName) {
        return StringUtils.hasText(productName) ? product.name.contains(productName) : null;
    }

    public static BooleanExpression productStatusEq(ProductStatus status) {
        return status != null ? product.status.eq(status) : null;
    }

    public static BooleanExpression vendorNameContains(String vendorName) {
        return StringUtils.hasText(vendorName) ? product.vendor.name.containsIgnoreCase(vendorName) : null;
    }
}
