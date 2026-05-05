package com.fourweekdays.fourweekdays.vendor.repository;

import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorSearchCondition;
import com.fourweekdays.fourweekdays.vendor.model.dto.request.VendorSearchRequest;
import com.fourweekdays.fourweekdays.vendor.model.dto.response.VendorProductResponse;
import com.fourweekdays.fourweekdays.vendor.model.entity.Vendor;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.fourweekdays.fourweekdays.product.model.entity.QProduct.product;
import static com.fourweekdays.fourweekdays.vendor.model.entity.QVendor.vendor;

@RequiredArgsConstructor
public class VendorRepositoryCustomImpl implements VendorRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<Vendor> findAllWithPaging(Pageable pageable) {
        List<Vendor> content = queryFactory
                .selectFrom(vendor)
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(vendor.createdAt.desc())
                .fetch();

        Long total = queryFactory
                .select(vendor.count())
                .from(vendor)
                .fetchOne();

        return new PageImpl<>(content, pageable, total);
    }

    @Override
    public Page<Vendor> search(Pageable pageable, VendorSearchCondition condition) {
        List<Vendor> content = queryFactory
                .selectFrom(vendor)
                .where(
                        vendorStatusEq(condition.status()),
                        vendorNameLike(condition.name()),
                        vendorCodeLike(condition.vendorCode()),
                        managerNameLike(condition.managerName()),
                        phoneNumberLike(condition.phoneNumber()),
                        emailLike(condition.email())
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(vendor.updatedAt.desc())
                .fetch();

        Long total = queryFactory
                .select(vendor.count())
                .from(vendor)
                .where(
                        vendorStatusEq(condition.status()),
                        vendorNameLike(condition.name()),
                        vendorCodeLike(condition.vendorCode()),
                        managerNameLike(condition.managerName()),
                        phoneNumberLike(condition.phoneNumber()),
                        emailLike(condition.email())
                )
                .fetchOne();

        return new PageImpl<>(content, pageable, total != null ? total : 0L);
    }

    @Override
    public Page<VendorProductResponse> searchVendorByProduct(Pageable pageable, VendorSearchRequest request) {

        // 1️⃣ vendor 기준 distinct 페이징
        List<Vendor> vendors = queryFactory
                .selectDistinct(vendor)
                .from(vendor)
                .leftJoin(product).on(product.vendor.eq(vendor))
                .where(
                        vendorCodeEq(request.vendorCode()),
                        vendorNameLike(request.vendorName()),
                        productCodeLike(request.productCode()),
                        productNameLike(request.productName())
                )
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .orderBy(vendor.name.asc())
                .fetch();

        if (vendors.isEmpty()) {
            return new PageImpl<>(List.of(), pageable, 0);
        }

        // 2️⃣ 해당 vendor들의 product 리스트
        List<Long> vendorIds = vendors.stream().map(Vendor::getId).toList();

        List<Product> products = queryFactory
                .selectFrom(product)
                .leftJoin(product.vendor, vendor).fetchJoin()
                .where(
                        product.vendor.id.in(vendorIds),
                        productCodeLike(request.productCode()),
                        productNameLike(request.productName())
                )
                .fetch();

        // 3️⃣ vendor별 상품 그룹핑
        Map<Long, List<Product>> productMap = products.stream()
                .collect(Collectors.groupingBy(p -> p.getVendor().getId()));

        // 4️⃣ DTO 변환
        List<VendorProductResponse> result = vendors.stream()
                .map(v -> VendorProductResponse.from(v, productMap.getOrDefault(v.getId(), List.of())))
                .toList();

        // 5️⃣ total count
        Long total = queryFactory
                .select(vendor.countDistinct())
                .from(vendor)
                .leftJoin(product).on(product.vendor.eq(vendor))
                .where(
                        vendorCodeEq(request.vendorCode()),
                        vendorNameLike(request.vendorName()),
                        productCodeLike(request.productCode()),
                        productNameLike(request.productName())
                )
                .fetchOne();

        return new PageImpl<>(result, pageable, total != null ? total : 0L);
    }

    // === 조건 ===
    private BooleanExpression vendorCodeEq(String vendorCode) {
        return StringUtils.hasText(vendorCode) ? vendor.vendorCode.eq(vendorCode) : null;
    }

    private BooleanExpression vendorCodeLike(String vendorCode) {
        return StringUtils.hasText(vendorCode) ? vendor.vendorCode.containsIgnoreCase(vendorCode) : null;
    }

    private BooleanExpression vendorNameLike(String vendorName) {
        return StringUtils.hasText(vendorName) ? vendor.name.containsIgnoreCase(vendorName) : null;
    }

    private BooleanExpression vendorStatusEq(com.fourweekdays.fourweekdays.vendor.model.entity.VendorStatus status) {
        return status != null ? vendor.status.eq(status) : null;
    }

    private BooleanExpression managerNameLike(String managerName) {
        return StringUtils.hasText(managerName) ? vendor.managerName.containsIgnoreCase(managerName) : null;
    }

    private BooleanExpression phoneNumberLike(String phoneNumber) {
        return StringUtils.hasText(phoneNumber) ? vendor.phoneNumber.contains(phoneNumber) : null;
    }

    private BooleanExpression emailLike(String email) {
        return StringUtils.hasText(email) ? vendor.email.containsIgnoreCase(email) : null;
    }

    private BooleanExpression productCodeLike(String productCode) {
        return StringUtils.hasText(productCode) ? product.productCode.contains(productCode) : null;
    }

    private BooleanExpression productNameLike(String productName) {
        return StringUtils.hasText(productName) ? product.name.contains(productName) : null;
    }

}
