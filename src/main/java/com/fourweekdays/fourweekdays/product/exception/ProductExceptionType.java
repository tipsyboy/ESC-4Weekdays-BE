package com.fourweekdays.fourweekdays.product.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

public enum ProductExceptionType implements ExceptionType {

    PRODUCT_NOT_FOUND(NOT_FOUND, "해당 상품 찾을 수 없습니다."),

    PRODUCT_DUPLICATION(CONFLICT, "이미 등록된 상품입니다. 다시 한 번 확인해 주세요.");

    private final HttpStatus httpStatus;
    private final String message;

    ProductExceptionType(HttpStatus httpStatus, String message) {
        this.httpStatus = httpStatus;
        this.message = message;
    }

    @Override
    public HttpStatus statusCode() {
        return this.httpStatus;
    }

    @Override
    public String message() {
        return this.message;
    }
}
