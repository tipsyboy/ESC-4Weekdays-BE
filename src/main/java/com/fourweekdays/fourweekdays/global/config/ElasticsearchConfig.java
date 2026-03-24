package com.fourweekdays.fourweekdays.global.config;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.mapping.IndexCoordinates;

@Slf4j
@RequiredArgsConstructor
@Configuration
public class ElasticsearchConfig {

    private final ElasticsearchOperations elasticsearchOperations;

    @PostConstruct
    public void checkConnection() {
        try {
            // 인덱스 존재 여부나 클러스터 상태를 간단히 체크
            boolean exists = elasticsearchOperations.indexOps(IndexCoordinates.of("products_test")).exists();
            log.info("✅ Elasticsearch 연결 성공! 'products_test' 인덱스 존재 여부: {}", exists);
        } catch (Exception e) {
            log.error("❌ Elasticsearch 연결 실패: {}", e.getMessage());
        }
    }
}