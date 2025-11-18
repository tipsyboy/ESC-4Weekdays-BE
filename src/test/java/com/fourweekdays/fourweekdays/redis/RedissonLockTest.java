package com.fourweekdays.fourweekdays.redis;

import com.fourweekdays.fourweekdays.common.generator.service.RedissonSequenceService;
import org.junit.jupiter.api.Test;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@SpringBootTest
public class RedissonLockTest {

    @Autowired
    private RedissonSequenceService redissonSequenceService;

    @Autowired
    private RedissonClient redissonClient; // 사용 안 하더라도 Redisson 제대로 뜨는지 확인용

    @Test
    void redisson_분산락_동시성_테스트() throws InterruptedException {
        int threadCount = 1000;
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        CountDownLatch latch = new CountDownLatch(threadCount);
        Set<String> generatedCodes = ConcurrentHashMap.newKeySet();

        long start = System.currentTimeMillis();

        for (int i = 0; i < threadCount; i++) {
            executor.submit(() -> {
                try {
                    String result = redissonSequenceService.generate("ORD");
                    generatedCodes.add(result);
                } catch (Exception e) {
                    System.out.println("락 실패: " + e.getMessage());
                } finally {
                    latch.countDown();
                }
            });
        }

        latch.await();
        executor.shutdown();

        long end = System.currentTimeMillis();

        System.out.println("\n\n================= V4(Redisson 분산락) 동시성 테스트 결과 =================");
        System.out.println("생성된 유니크 코드 개수     : " + generatedCodes.size());
        System.out.println("요청 스레드 수              : " + threadCount);
        System.out.println("중복 없이 잘 생성되었는지   : " + (generatedCodes.size() == threadCount));
        System.out.println("총 소요 시간(ms)           : " + (end - start));
        System.out.println("====================================================================\n");
    }
}
