package com.fourweekdays.fourweekdays.asn.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.BAD_REQUEST;
import static org.springframework.http.HttpStatus.CONFLICT;

public enum ASNExceptionType implements ExceptionType {

    VENDOR_MISMATCH(BAD_REQUEST, "발주서의 공급업체가 일치하지 않습니다"),

    ASN_DUPLICATION(CONFLICT, "이미 등록된 ASN입니다.");

    private final HttpStatus status;
    private final String message;

    ASNExceptionType(HttpStatus status, String message) {
        this.status = status;
        this.message = message;
    }

    @Override
    public HttpStatus statusCode() {
        return this.status;
    }

    @Override
    public String message() {
        return this.message;
    }
}
