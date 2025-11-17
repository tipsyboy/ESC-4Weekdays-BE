package com.fourweekdays.fourweekdays.redis;

import com.fourweekdays.fourweekdays.common.generator.service.RedissonSequenceService;
import com.fourweekdays.fourweekdays.config.RedissonConfig;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.context.annotation.Import;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.test.context.ActiveProfiles;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@DataJpaTest
@Import({RedissonConfig.class, RedissonSequenceService.class})
@ActiveProfiles("test")
@EnableJpaRepositories(
        basePackages = "com.fourweekdays.fourweekdays.common.generator.repository"
)
public class RedissonLockTest {

    @Autowired
    private RedissonSequenceService redissonSequenceService;

    @Test
    void concurrentLockTest() throws InterruptedException {
        int threadCount = 1000;
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        CountDownLatch latch = new CountDownLatch(threadCount);
        Set<String> generatedCodes = ConcurrentHashMap.newKeySet();

        for (int i = 0; i < threadCount; i++) {
            executor.submit(() -> {
                try {
                    String result = redissonSequenceService.generate("ORD");
                    generatedCodes.add(result);
                } catch(Exception e) {
                    System.out.println("락 실패: " + e.getMessage());
                }
                finally {
                    latch.countDown();
                }
            });
        }

        latch.await();
        executor.shutdown();

        System.out.println("생성된 유니크 코드 개수: " + generatedCodes.size());
        generatedCodes.forEach(System.out::println);
    }
}
