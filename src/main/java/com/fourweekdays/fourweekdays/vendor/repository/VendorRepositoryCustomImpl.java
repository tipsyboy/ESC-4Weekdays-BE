package com.fourweekdays.fourweekdays.vendor.repository;

import com.fourweekdays.fourweekdays.vendor.dto.VendorSearchCondition;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import com.fourweekdays.fourweekdays.vendor.domain.VendorStatus;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.util.StringUtils;

import java.util.List;
import static com.fourweekdays.fourweekdays.vendor.domain.QVendor.vendor;

@RequiredArgsConstructor
public class VendorRepositoryCustomImpl implements VendorRepositoryCustom {

    private final JPAQueryFactory queryFactory;

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

    // === 조건 ===
    private BooleanExpression vendorCodeLike(String vendorCode) {
        return StringUtils.hasText(vendorCode) ? vendor.vendorCode.containsIgnoreCase(vendorCode) : null;
    }

    private BooleanExpression vendorNameLike(String vendorName) {
        return StringUtils.hasText(vendorName) ? vendor.name.containsIgnoreCase(vendorName) : null;
    }

    private BooleanExpression vendorStatusEq(VendorStatus status) {
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

}
