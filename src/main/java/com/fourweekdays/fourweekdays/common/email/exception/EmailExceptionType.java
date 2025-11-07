package com.fourweekdays.fourweekdays.common.email.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@RequiredArgsConstructor
public enum EmailExceptionType implements ExceptionType {
    EMAIL_NOT_SENT(HttpStatus.INTERNAL_SERVER_ERROR, "이메일 전송에 실패하였습니다.");


    private final HttpStatus httpStatus;
    private final String message;

    @Override
    public HttpStatus statusCode() {
        return null;
    }

    @Override
    public String message() {
        return "";
    }
}
