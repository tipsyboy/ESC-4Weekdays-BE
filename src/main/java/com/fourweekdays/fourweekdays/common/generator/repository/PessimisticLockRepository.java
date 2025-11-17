package com.fourweekdays.fourweekdays.common.generator.repository;

import com.fourweekdays.fourweekdays.common.generator.entity.Sequence;
import jakarta.persistence.LockModeType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Lock;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface PessimisticLockRepository extends JpaRepository<Sequence, String> {

    @Lock(LockModeType.PESSIMISTIC_WRITE)
    @Query("SELECT s FROM Sequence s WHERE s.prefix = :prefix")     // 쿼리 조회 시 roe-level lock 획득
    Optional<Sequence> findByPrefixForUpdate(@Param("prefix") String prefix);
}
