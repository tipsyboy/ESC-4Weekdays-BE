package com.fourweekdays.fourweekdays.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeIn;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.models.OpenAPI;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@OpenAPIDefinition(
        info = @Info(title = "FourWeekdays API", version = "v1"),
        security = { @SecurityRequirement(name = "apiKey") } // 모든 API에 기본 적용
)
@SecurityScheme(
        name = "apiKey", // SecurityRequirement에서 참조할 이름
        type = SecuritySchemeType.APIKEY,
        in = SecuritySchemeIn.HEADER, // 헤더에서 가져오도록 설정
        paramName = "X-API-KEY", // 실제 header 이름
        description = "API Key를 입력하세요 (예: 76ef0946-8951-4ea1-99d5-42d7ee0fc900)"
)
@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new io.swagger.v3.oas.models.info.Info()
                        .title("4Weekdays WMS API")
                        .description("물류 창고 관리 시스템")
                        .version("0.1.0"));
    }
}
