package com.fourweekdays.fourweekdays.product.repository;

import com.fourweekdays.fourweekdays.product.model.dto.request.ProductSearchRequest;
import com.fourweekdays.fourweekdays.product.model.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ProductRepositoryCustom {

    Page<Product> searchProducts(Pageable pageable, ProductSearchRequest request);

    List<Product> findAllProductsForIndexing();
}
