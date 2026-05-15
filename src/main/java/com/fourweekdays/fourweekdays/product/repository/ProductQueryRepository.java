package com.fourweekdays.fourweekdays.product.repository;

import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.product.domain.ProductStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ProductQueryRepository {
    Page<Product> search(
            String vendorName,
            String productCode,
            String productName,
            String category,
            ProductStatus status,
            Pageable pageable
    );
}
