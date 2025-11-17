package com.fourweekdays.fourweekdays.redis;

import com.fourweekdays.fourweekdays.common.generator.CodeGeneratorV1;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;

@SpringBootTest(classes = CodeGeneratorV1.class)
public class CodeGeneratorTestV1 {

    @Autowired
    private CodeGeneratorV1 codeGeneratorV1;

    @Test
    void 일련번호생성() throws Exception {
        int threadCount = 100;
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        CountDownLatch readyLatch = new CountDownLatch(threadCount);
        CountDownLatch startLatch = new CountDownLatch(1);
        CountDownLatch doneLatch = new CountDownLatch(threadCount);

        Set<String> codes = ConcurrentHashMap.newKeySet();

        for (int i = 0; i < threadCount; i++) {
            executor.execute(() -> {
                try {
                    readyLatch.countDown();
                    startLatch.await(); // 모든 스레드 동시에 시작

                    String code = codeGeneratorV1.generate("V1");
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

        assertThat(codes.size())
                .as("DB 기반 시퀀스 구조에서 동시성 제어가 없을 경우 중복 코드 발생 가능")
                .isLessThan(threadCount);
    }

}
