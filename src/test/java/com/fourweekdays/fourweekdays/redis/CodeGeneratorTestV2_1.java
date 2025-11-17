package com.fourweekdays.fourweekdays.redis;

import com.fourweekdays.fourweekdays.common.generator.CodeGeneratorV2;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@SpringBootTest(classes = CodeGeneratorV2.class)
public class CodeGeneratorTestV2_1 {

    @Test
    void synchronized_서버_여러대면_동시성_이슈_발생() throws Exception {

        // 서버 2대
        CodeGeneratorV2 server1 = new CodeGeneratorV2();
        CodeGeneratorV2 server2 = new CodeGeneratorV2();

        int threadCount = 100;
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        CountDownLatch readyLatch = new CountDownLatch(threadCount);
        CountDownLatch startLatch = new CountDownLatch(1);
        CountDownLatch doneLatch = new CountDownLatch(threadCount);

        Set<String> codes = ConcurrentHashMap.newKeySet();

        for (int i = 0; i < threadCount; i++) {
            final int serverIdx = i % 2;        // 짝수 스레드는 서버1, 홀수는 서버 2
            executor.execute(() -> {
                try {
                    readyLatch.countDown();
                    startLatch.await(); // 모든 스레드 동시에 시작

                    CodeGeneratorV2 generator = (serverIdx == 0) ? server1 : server2;
                    String code = generator.generate("V2-1");
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
        executor.shutdown();

        System.out.println("=== 생성된 코드 목록 ===");
        codes.stream().sorted().forEach(System.out::println);
        System.out.println("총 생성된 코드 수: " + codes.size());
    }

}
