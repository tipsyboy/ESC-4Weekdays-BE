package com.fourweekdays.fourweekdays.redis;

import com.fourweekdays.fourweekdays.common.generator.CodeGeneratorV2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@SpringBootTest(classes = CodeGeneratorV2.class)
public class CodeGeneratorTestV2 {

    @Autowired
    private CodeGeneratorV2 codeGeneratorV2;

    @Test
    void synchronized_적용시_동시성_이슈_해결() throws Exception {
        int threadCount = 100;
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        CountDownLatch readyLatch = new CountDownLatch(threadCount);
        CountDownLatch startLatch = new CountDownLatch(1);
        CountDownLatch doneLatch = new CountDownLatch(threadCount);

        Set<String> codes = ConcurrentHashMap.newKeySet();

        long start = System.currentTimeMillis();

        for (int i = 0; i < threadCount; i++) {
            executor.execute(() -> {
                try {
                    readyLatch.countDown();
                    startLatch.await(); // 모든 스레드 동시에 시작

                    String code = codeGeneratorV2.generate("V2");
                    codes.add(code);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    doneLatch.countDown();
                }
            });
        }

        // 모든 스레드 준비 완료 후 동시 시작
        readyLatch.await();
        startLatch.countDown();
        doneLatch.await();

        long end = System.currentTimeMillis();
        executor.shutdown();

        System.out.println("\n\n================= V2(synchronized) 동시성 테스트 결과 =================");
        System.out.println("생성한 코드 수              : " + codes.size());
        System.out.println("스레드 수                   : " + threadCount);
        System.out.println("중복 없이 잘 생성되었는지   : " + (codes.size() == threadCount));
        System.out.println("총 소요 시간(ms)           : " + (end - start));
        System.out.println("=================================================================\n");
    }
}
