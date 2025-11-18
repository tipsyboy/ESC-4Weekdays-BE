package com.fourweekdays.fourweekdays.redis;

import com.fourweekdays.fourweekdays.common.generator.entity.Sequence;
import com.fourweekdays.fourweekdays.common.generator.repository.PessimisticLockRepository;
import com.fourweekdays.fourweekdays.common.generator.service.SequencePessimisticLockService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Set;
import java.util.concurrent.*;

@SpringBootTest
public class CodeGeneratorTestV3 {

    @Autowired
    private PessimisticLockRepository pessimisticLockRepository;

    @Autowired
    private SequencePessimisticLockService sequencePessimisticLockService;

    @BeforeEach
    void setup() {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        pessimisticLockRepository.deleteAll();

        pessimisticLockRepository.saveAndFlush(
                Sequence.builder()
                        .prefix("ORD")
                        .currentValue(0)
                        .lastDate(today)
                        .build()
        );
    }

    @Test
    void 비관적락_테스트() throws Exception {

        int threadCount = 1000;
        ExecutorService executor = Executors.newFixedThreadPool(64);
        CountDownLatch latch = new CountDownLatch(threadCount);

        Set<String> generatedCodes = ConcurrentHashMap.newKeySet();

        long start = System.currentTimeMillis();

        for (int i = 0; i < threadCount; i++) {
            executor.execute(() -> {
                try {
                    generatedCodes.add(sequencePessimisticLockService.generate("ORD"));
                } finally {
                    latch.countDown();
                }
            });
        }

        latch.await();
        executor.shutdown();

        long end = System.currentTimeMillis();

        System.out.println("\n\n================= V3(DB 비관적 락) 동시성 테스트 결과 =================");
        System.out.println("생성된 코드 수              : " + generatedCodes.size());
        System.out.println("요청 스레드 수              : " + threadCount);
        System.out.println("중복 없이 잘 생성되었는지   : " + (generatedCodes.size() == threadCount));
        System.out.println("총 소요 시간(ms)           : " + (end - start));
        System.out.println("=================================================================\n");
    }
}
