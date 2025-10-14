package com.fourweekdays.fourweekdays.vendor.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import org.springframework.http.HttpStatus;

public enum VendorExceptionType implements ExceptionType {
    // 구조만 따라함 아직 사용 x
    ;

    private final HttpStatus httpStatus;
    private final String message;

    VendorExceptionType(HttpStatus httpStatus, String message) {
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
