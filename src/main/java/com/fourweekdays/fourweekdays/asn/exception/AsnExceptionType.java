package com.fourweekdays.fourweekdays.asn.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

public enum AsnExceptionType implements ExceptionType {

    VENDOR_MISMATCH(BAD_REQUEST, "발주서의 공급업체가 일치하지 않습니다"),

    ASN_NOT_FOUND(NOT_FOUND, "해당 ASN을 찾을 수 없습니다."),

    ASN_ALREADY_EXISTS(CONFLICT, "이미 수신한 ASN 입니다."),

    ASN_INVALID_REQUEST(BAD_REQUEST, "ASN 요청 데이터가 유효하지 않습니다.");

    private final HttpStatus status;
    private final String message;

    AsnExceptionType(HttpStatus status, String message) {
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
