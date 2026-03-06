package com.fourweekdays.fourweekdays.auth.exception;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
public class JwtExceptionResponseDto {

    private String path;
    private LocalDateTime timestamp;
    private Integer statusCode;
    private String exceptionCode;
    private String message;

    @Builder
    public JwtExceptionResponseDto(String path, LocalDateTime timestamp, Integer statusCode, String exceptionCode, String message) {
        this.path = path;
        this.timestamp = timestamp;
        this.statusCode = statusCode;
        this.exceptionCode = exceptionCode;
        this.message = message;
    }
}