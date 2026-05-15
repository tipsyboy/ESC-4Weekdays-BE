package com.fourweekdays.fourweekdays.global.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Component;

@Primary
@Component("naiveSequenceCodeGenerator")
public class NaiveSequenceCodeGenerator implements CodeGenerator {

    private static final int SEQUENCE_PADDING = 6;

    // 의도적으로 동기화하지 않는다. 동시 요청 시 중복 코드가 발생할 수 있는 임시 순차 생성기다.
    private final Map<String, Long> sequences = new HashMap<>();

    @Override
    public String generate(CodeType codeType) {
        String date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String sequenceKey = codeType.name() + ":" + date;

        Long current = sequences.getOrDefault(sequenceKey, 0L);
        long next = current + 1;
        sequences.put(sequenceKey, next);

        return codeType.getPrefix() + "-" + date + "-" + String.format("%0" + SEQUENCE_PADDING + "d", next);
    }
}
