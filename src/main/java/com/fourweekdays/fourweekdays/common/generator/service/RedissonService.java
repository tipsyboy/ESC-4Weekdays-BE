package com.fourweekdays.fourweekdays.common.generator.service;

import lombok.RequiredArgsConstructor;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class RedissonService {

    private final RedissonClient redissonClient;
    private final RedissonSequenceService redissonSequenceService;

    public String generate(String prefix) {
        String lockKey = "lock:" + prefix;
        // redissonClient 역할 공부
        RLock lock = redissonClient.getLock(lockKey);
        // try-catch문 공부
        try {
            if (lock.tryLock(3, 10, TimeUnit.SECONDS)) {
                try {
                    return redissonSequenceService.generate(prefix);
                } finally {
                    lock.unlock();
                }
            } else {
                throw new IllegalStateException("Lock 획득 실패");
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new RuntimeException("락 대기 중 인터럽트 발생", e);
        }
    }
}
