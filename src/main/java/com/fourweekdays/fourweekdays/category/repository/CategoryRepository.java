package com.fourweekdays.fourweekdays.category.repository;

import com.fourweekdays.fourweekdays.category.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    Optional<Category> findByNameAndParentIsNull(String name);
    Optional<Category> findByNameAndParent(String name, Category parent);
}
