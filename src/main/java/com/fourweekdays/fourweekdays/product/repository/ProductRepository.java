package com.fourweekdays.fourweekdays.product.repository;

import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.product.model.entity.ProductStatus;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Long>, ProductRepositoryCustom {

    boolean existsByVendorAndName(Vendor vendor, String name);

    Page<Product> findByStatus(ProductStatus status, Pageable pageable);

    Page<Product> findByVendorIdAndStatus(Long vendorId, ProductStatus status, Pageable pageable);

    List<Product> findByVendorId(Long vendorId);
}
