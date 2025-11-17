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
        Sequence seq = getOrCreateSequence(prefix);
        seq.increase();
        return formatCode(prefix, seq.getCurrentValue());
    }

    private Sequence getOrCreateSequence(String prefix) {
        return repository.findByPrefixForUpdate(prefix)
                .orElseGet(() -> createOrGetExisting(prefix));
    }

    private Sequence createOrGetExisting(String prefix) {
        try {
            return repository.save(new Sequence(prefix, 0));
        } catch (DataIntegrityViolationException e) {
            return repository.findByPrefixForUpdate(prefix)
                    .orElseThrow(() -> new IllegalStateException("Sequence race condition 발생"));
        }
    }

    private String formatCode(String prefix, int value) {
        String datePart = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        return String.format("%s-%s-%04d", prefix, datePart, value);
    }
}
