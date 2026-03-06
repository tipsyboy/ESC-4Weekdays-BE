package com.fourweekdays.fourweekdays.auth.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fourweekdays.fourweekdays.auth.exception.JwtExceptionResponseDto;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.LocalDateTime;

@Slf4j
@RequiredArgsConstructor
@Component
public class JwtAccessDeniedHandler implements AccessDeniedHandler {

    private final ObjectMapper objectMapper;

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {
        log.error("[JWT Access Denied Handler]: {}", accessDeniedException.getMessage());

        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("utf-8");

        // DTO를 사용한 체계적 응답
        JwtExceptionResponseDto responseDto = JwtExceptionResponseDto.builder()
                .path(request.getRequestURI())
                .timestamp(LocalDateTime.now())
                .statusCode(HttpServletResponse.SC_FORBIDDEN)
                .exceptionCode("ACCESS_DENIED")
                .message("접근 권한이 없습니다.")
                .build();

        String jsonResponse = objectMapper.writeValueAsString(responseDto);
        response.getWriter().write(jsonResponse);
    }
}
