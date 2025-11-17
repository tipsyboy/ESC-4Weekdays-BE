package com.fourweekdays.fourweekdays.zz_redis_test;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RedisHealthController {

    private final RedisHealthChecker redisHealthChecker;

    public RedisHealthController(RedisHealthChecker redisHealthChecker) {
        this.redisHealthChecker = redisHealthChecker;
    }

    @GetMapping("/health/redis")
    public String checkRedis() {
        return redisHealthChecker.isAlive() ? "Redis OK" : "Redis DOWN";
    }
}

