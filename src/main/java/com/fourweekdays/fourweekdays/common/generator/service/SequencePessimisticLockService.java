package com.fourweekdays.fourweekdays.common.generator.service;

import com.fourweekdays.fourweekdays.common.generator.entity.Sequence;
import com.fourweekdays.fourweekdays.common.generator.repository.PessimisticLockRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
@RequiredArgsConstructor
public class SequencePessimisticLockService {

    private final PessimisticLockRepository repository;

    @Transactional
    public String generate(String prefix) {

        Sequence seq = repository.findByPrefixForUpdate(prefix)
                .orElseGet(() -> createOrGetExisting(prefix));

        seq.increase();

        return formatCode(prefix, seq.getCurrentValue());
    }

    private Sequence createOrGetExisting(String prefix) {
        try {
            return repository.saveAndFlush(
                    Sequence.builder()
                            .prefix(prefix)
                            .currentValue(0)
                            .lastDate(today())
                            .build()
            );
        } catch (DataIntegrityViolationException e) {
            return repository.findByPrefixForUpdate(prefix)
                    .orElseThrow(() -> new IllegalStateException("Sequence race condition 발생"));
        }
    }

    private String today() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
    }

    private String formatCode(String prefix, int value) {
        return String.format("%s-%s-%04d", prefix, today(), value);
    }
}
