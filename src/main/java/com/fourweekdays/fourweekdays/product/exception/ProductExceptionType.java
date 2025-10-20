package com.fourweekdays.fourweekdays.product.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import org.springframework.http.HttpStatus;

/**
 * 상품 도메인 예외 유형
 */
public enum ProductExceptionType implements ExceptionType {

    PRODUCT_NOT_FOUND(HttpStatus.NOT_FOUND, "상품을 찾을 수 없습니다."),
    FILE_UPLOAD_FAILED(HttpStatus.INTERNAL_SERVER_ERROR, "이미지 업로드 중 오류가 발생했습니다."),
    PRODUCT_REGISTER_FAILED(HttpStatus.INTERNAL_SERVER_ERROR, "상품 등록 중 오류가 발생했습니다."),
    INVALID_PRODUCT_REQUEST(HttpStatus.BAD_REQUEST, "상품 요청 데이터가 유효하지 않습니다.");

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
