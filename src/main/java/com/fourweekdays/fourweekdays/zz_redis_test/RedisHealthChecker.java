package com.fourweekdays.fourweekdays.zz_redis_test;

import org.redisson.api.RedissonClient;
import org.springframework.stereotype.Component;

@Component
public class RedisHealthChecker {

    private final RedissonClient redissonClient;

    public RedisHealthChecker(RedissonClient redissonClient) {
        this.redissonClient = redissonClient;
    }

    public boolean isAlive() {
        try {
            // 단순 ping 테스트
            redissonClient.getBucket("health_check_temp").isExists();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}