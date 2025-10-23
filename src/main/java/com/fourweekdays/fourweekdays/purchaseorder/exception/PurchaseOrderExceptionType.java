package com.fourweekdays.fourweekdays.purchaseorder.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

public enum PurchaseOrderExceptionType implements ExceptionType {

    PURCHASE_ORDER_CANNOT_REJECT(BAD_REQUEST, "현재 상태에서는 거절할 수 없습니다"),

    PURCHASE_ORDER_NOT_FOUND(NOT_FOUND, "해당 발주서를 찾을 수 없습니다."),

    PURCHASE_ORDER_CANNOT_UPDATE_AFTER_APPROVAL(CONFLICT, "이미 승인된 발주서는 수정할 수 없습니다."),
    PURCHASE_ORDER_CANNOT_CANCEL_AFTER_APPROVAL(CONFLICT, "이미 승인된 발주서는 취소할 수 없습니다.");

    private final HttpStatus httpStatus;
    private final String message;

    PurchaseOrderExceptionType(HttpStatus httpStatus, String message) {
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
