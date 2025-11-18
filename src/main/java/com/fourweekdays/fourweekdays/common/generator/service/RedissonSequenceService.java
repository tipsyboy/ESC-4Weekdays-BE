package com.fourweekdays.fourweekdays.common.generator.service;

import com.fourweekdays.fourweekdays.common.generator.entity.Sequence;
import com.fourweekdays.fourweekdays.common.generator.repository.SequenceRepository;
import lombok.RequiredArgsConstructor;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class RedissonSequenceService {

    private final RedissonClient redissonClient;
    private final SequenceRepository repository;

    private static final int LOCK_WAIT_SECONDS = 3;
    private static final int LOCK_LEASE_SECONDS = 10;
    private static final int MAX_RETRIES = 5;
    private static final long RETRY_DELAY_MS = 50;

    private static final DateTimeFormatter DATE_FMT =
            DateTimeFormatter.ofPattern("yyyyMMdd");

    @Transactional
    public String generate(String prefix) {

        String lockKey = "lock:seq:" + prefix;
        RLock lock = redissonClient.getLock(lockKey);

        for (int attempt = 0; attempt <= MAX_RETRIES; attempt++) {
            try {
                if (lock.tryLock(LOCK_WAIT_SECONDS, LOCK_LEASE_SECONDS, TimeUnit.SECONDS)) {

                    try {
                        String today = LocalDate.now().format(DATE_FMT);

                        Sequence seq = repository.findByPrefix(prefix)
                                .orElseGet(() ->
                                        repository.save(
                                                Sequence.builder()
                                                        .prefix(prefix)
                                                        .currentValue(0)
                                                        .lastDate(today)
                                                        .build()
                                        )
                                );

                        if (!today.equals(seq.getLastDate())) {
                            seq.reset(today);
                        }

                        seq.increase();

                        return formatCode(prefix, today, seq.getCurrentValue());

                    } finally {
                        lock.unlock();
                    }

                } else {
                    Thread.sleep(RETRY_DELAY_MS);
                }

            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                throw new RuntimeException("락 대기 중 인터럽트 발생", e);
            }
        }

        throw new IllegalStateException("Lock 획득 실패: 최대 재시도 " + MAX_RETRIES + "회");
    }

    private String formatCode(String prefix, String datePart, int value) {
        return String.format("%s-%s-%04d", prefix, datePart, value);
    }
}
