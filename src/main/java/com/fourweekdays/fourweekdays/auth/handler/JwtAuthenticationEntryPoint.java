package com.fourweekdays.fourweekdays.auth.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fourweekdays.fourweekdays.auth.exception.JwtExceptionResponseDto;
import com.fourweekdays.fourweekdays.auth.exception.JwtExceptionType;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.LocalDateTime;

@Slf4j
@RequiredArgsConstructor
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final ObjectMapper objectMapper;

    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        log.error("[JWT Authentication Entry Point]: {}", authException.getMessage());

        String exception = (String) request.getAttribute("exception");

        if (exception == null) {
            exception = JwtExceptionType.NOT_FOUND_TOKEN.getCode();
        }

        JwtExceptionType exceptionType = JwtExceptionType.valueOf(exception);
        log.error("entry point >> {}", exceptionType.getMessage());
        setResponse(response, exceptionType, request.getRequestURI());
    }

    private void setResponse(HttpServletResponse response, JwtExceptionType exceptionCode, String path) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setCharacterEncoding("utf-8");

        JwtExceptionResponseDto jwtExceptionResponseDto = JwtExceptionResponseDto.builder()
                .path(path)
                .timestamp(LocalDateTime.now())
                .statusCode(HttpStatus.UNAUTHORIZED.value())
                .exceptionCode(exceptionCode.getCode())
                .message(exceptionCode.getMessage())
                .build();

        String jsonResponse = objectMapper.writeValueAsString(jwtExceptionResponseDto);
        response.getWriter().write(jsonResponse);
    }
}
