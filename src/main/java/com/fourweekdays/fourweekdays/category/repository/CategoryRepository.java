package com.fourweekdays.fourweekdays.category.repository;

import com.fourweekdays.fourweekdays.category.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Long> {
}
