package com.fourweekdays.fourweekdays.inbound.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.NOT_FOUND;

public enum InboundExceptionType implements ExceptionType {

    INBOUND_NOT_FOUND(NOT_FOUND, "해당 발주를 찾을 수 없습니다.");

    private final HttpStatus httpStatus;
    private final String message;

    InboundExceptionType(HttpStatus httpStatus, String message) {
        this.httpStatus = httpStatus;
        this.message = message;
    }

    @Override
    public HttpStatus statusCode() {
        return null;
    }

    @Override
    public String message() {
        return "";
    }
}
