package com.fourweekdays.fourweekdays.inbound.repository;

import com.fourweekdays.fourweekdays.inbound.model.entity.Inbound;
import com.fourweekdays.fourweekdays.inbound.model.entity.QInbound;
import com.fourweekdays.fourweekdays.inbound.model.entity.QInboundProduct;
import com.fourweekdays.fourweekdays.product.model.entity.QProduct;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Pageable;


import java.util.List;

@Repository
@RequiredArgsConstructor
public class InboundRepositoryCustomImpl implements InboundRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    private final QInbound inbound = QInbound.inbound;
    private final QInboundProduct inboundProduct = QInboundProduct.inboundProduct;
    private final QProduct product = QProduct.product;


    @Override
    public List<Inbound> searchInboundWithProduct(
            String inboundCode,
            String managerName,
            String productName,
            List<Long> vendorIds
    ) {
        BooleanBuilder inboundBuilder = new BooleanBuilder();
        if (inboundCode != null && !inboundCode.isEmpty()) {
            inboundBuilder.and(inbound.inboundCode.containsIgnoreCase(inboundCode));
        }
        if (managerName != null && !managerName.isEmpty()) {
            inboundBuilder.and(inbound.managerName.containsIgnoreCase(managerName));
        }

        BooleanBuilder productBuilder = new BooleanBuilder();
        if (productName != null && !productName.isEmpty()) {
            productBuilder.and(product.name.containsIgnoreCase(productName));
        }
        if (vendorIds != null && !vendorIds.isEmpty()) {
            productBuilder.and(product.vendor.id.in(vendorIds));
        }

        return queryFactory
                .selectDistinct(inbound)
                .from(inbound)
                .leftJoin(inbound.products, inboundProduct).fetchJoin()
                .leftJoin(inboundProduct.product, product).fetchJoin()
                .where(inboundBuilder.and(productBuilder))
                .fetch();
    }

    @Override
    public Page<Inbound> findAllWithPaging(Pageable pageable) {
        return null;
    }

}