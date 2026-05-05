package com.fourweekdays.fourweekdays.global.util;

import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Component
public class UuidCodeGenerator implements CodeGenerator {

    @Override
    public String generate(CodeType codeType) {
        return generate(codeType.getPrefix());
    }

    private String generate(String prefix) {
        String datePrefix = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        String randomSuffix = UUID.randomUUID()
                .toString()
                .replace("-", "")
                .substring(0, 6)
                .toUpperCase();

        // TODO: 추후 Redis 기반 일자별 시퀀스로 교체하여 동시성 하에서도 순차 코드 보장
        return prefix + "-" + datePrefix + "-" + randomSuffix;
    }
}
