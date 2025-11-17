package com.fourweekdays.fourweekdays.redis;

import com.fourweekdays.fourweekdays.config.RedissonConfig;
import org.junit.jupiter.api.Test;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.junit.jupiter.SpringJUnitConfig;

import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringJUnitConfig(classes = RedissonConfig.class)
public class RedissonConnectionTest {

    @Autowired
    private RedissonClient redissonClient;

    @Test
    void redissonClientTest() {
        var bucket = redissonClient.getBucket("test:key");
        bucket.set("hello");
        String value = (String) bucket.get();

        assertEquals("hello", value);
        System.out.println("Redis 연결 성공, 값: " + value);
    }

}
