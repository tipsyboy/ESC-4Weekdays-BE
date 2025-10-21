package com.fourweekdays.fourweekdays.franchise.repository;

import com.fourweekdays.fourweekdays.franchise.model.entity.FranchiseStore;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FranchiseRepository extends JpaRepository<FranchiseStore, Long>, FranchiseRepositoryCustom {
}
