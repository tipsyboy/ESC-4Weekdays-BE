package com.fourweekdays.fourweekdays.product.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.NOT_FOUND;

public enum ProductExceptionType implements ExceptionType {

    PRODUCT_NOT_FOUND(NOT_FOUND, "상품 찾을 수 없습니다.");

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
