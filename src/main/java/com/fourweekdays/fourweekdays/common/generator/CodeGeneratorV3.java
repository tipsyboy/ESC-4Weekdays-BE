package com.fourweekdays.fourweekdays.common.generator;

import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Component
public class CodeGeneratorV3 {
    // 가짜 테이블
    private final Map<String, Integer> sequenceTable = new HashMap<>();

    public synchronized String generate(String prefix) {
        String datePrefix = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        // DB SELECT
        Integer laseSeq = sequenceTable.getOrDefault(prefix, 0);

        // DB UPDATE
        int nextSeq = laseSeq + 1;
        sequenceTable.put(prefix, nextSeq);

        return String.format("%s-%s-%s", prefix, datePrefix, nextSeq);
    }
}