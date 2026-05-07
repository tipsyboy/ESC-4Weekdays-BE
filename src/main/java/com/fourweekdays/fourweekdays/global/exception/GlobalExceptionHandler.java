package com.fourweekdays.fourweekdays.global.exception;

import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<BaseResponse<Void>> validationExceptionHandler(MethodArgumentNotValidException e) {
        FieldError fieldError = e.getBindingResult().getFieldErrors().stream().findFirst().orElse(null);
        String errorMessage = fieldError != null ? fieldError.getDefaultMessage() : "잘못된 요청입니다.";

        log.warn("[ValidationException] >> {}", errorMessage);

        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(BaseResponse.fail(HttpStatus.BAD_REQUEST, errorMessage));
    }

    @ExceptionHandler(BaseException.class)
    public ResponseEntity<BaseResponse<Void>> baseExceptionHandler(BaseException e) {
        String errorClassName = e.getClass().getSimpleName();
        HttpStatus httpStatus = e.getExceptionType().statusCode();
        String errorMessage = e.getExceptionType().message();

        log.error("[{}] >> {}", errorClassName, errorMessage);

        if (e.getCause() != null) {
            log.error("[{} Cause] {}", errorClassName, e.getCause().getMessage(), e.getCause());
        }

        return ResponseEntity.status(httpStatus)
                .body(BaseResponse.fail(httpStatus, errorMessage));
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<BaseResponse<Void>> accessDeniedExceptionHandler(AccessDeniedException e) {
        log.warn("[AccessDeniedException] >> {}", e.getMessage());
        return ResponseEntity.status(HttpStatus.FORBIDDEN)
                .body(BaseResponse.fail(HttpStatus.FORBIDDEN, e.getMessage()));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<BaseResponse<Void>> globalExceptionHandler(Exception e) {
        log.error("[Exception] 예기치 못한 예외가 발생: {}", e.getMessage(), e);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(BaseResponse.fail(HttpStatus.INTERNAL_SERVER_ERROR, "서버 내부 오류가 발생했습니다"));
    }
}
