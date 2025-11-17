package com.fourweekdays.fourweekdays.redis;

import com.fourweekdays.fourweekdays.common.generator.entity.Sequence;
import com.fourweekdays.fourweekdays.common.generator.repository.PessimisticLockRepository;
import com.fourweekdays.fourweekdays.common.generator.service.SequencePessimisticLockService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.context.annotation.Import;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@DataJpaTest
@Import(SequencePessimisticLockService.class)
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@EnableJpaRepositories(basePackages = "com.fourweekdays.fourweekdays.common.generator.repository")
@EntityScan(basePackages = "com.fourweekdays.fourweekdays.common.generator")
@Transactional(propagation = Propagation.NOT_SUPPORTED)
class CodeGeneratorTestV3 {

    @Autowired
    private PessimisticLockRepository pessimisticLockRepository;

    @Autowired
    private SequencePessimisticLockService sequencePessimisticLockService;

    @BeforeEach
    void setup() {
        pessimisticLockRepository.saveAndFlush(new Sequence("ORD", 0));
    }

    @Test
    void 비관적락_테스트() throws Exception {
        int threadCount = 1000;
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);
        CountDownLatch latch = new CountDownLatch(threadCount);

        Set<String> generatedCodes = ConcurrentHashMap.newKeySet();

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

        System.out.println("=== 생성된 코드 목록 ===");
//        generatedCodes.forEach(System.out::println);
        System.out.println("총 생성된 코드 수: " + generatedCodes.size());
    }

}
