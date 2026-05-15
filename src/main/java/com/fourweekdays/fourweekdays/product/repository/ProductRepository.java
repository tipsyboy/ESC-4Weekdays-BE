package com.fourweekdays.fourweekdays.product.repository;

import com.fourweekdays.fourweekdays.product.domain.Product;
import com.fourweekdays.fourweekdays.vendor.domain.Vendor;
import java.util.List;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long>, ProductQueryRepository {

    boolean existsByVendorAndName(Vendor vendor, String name);

    @EntityGraph(attributePaths = {"vendor"})
    List<Product> findAllByVendorIdOrderByIdDesc(Long vendorId);

    @EntityGraph(attributePaths = {"vendor"})
    List<Product> findByVendorId(Long vendorId);

    long countByVendorId(Long vendorId);
}
