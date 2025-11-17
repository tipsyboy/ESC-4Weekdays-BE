package com.fourweekdays.fourweekdays.common.generator.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fourweekdays.fourweekdays.common.generator.entity.Sequence;
import java.util.Optional;

public interface SequenceRepository extends JpaRepository<Sequence, String> {

    Optional<Sequence> findByPrefix(String prefix);

}
