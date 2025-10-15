package com.fourweekdays.fourweekdays.product.exception;

import com.fourweekdays.fourweekdays.global.exception.BaseException;
import com.fourweekdays.fourweekdays.global.exception.ExceptionType;

public class ProductException extends BaseException {

    public ProductException(ExceptionType exceptionType) {
        super(exceptionType);
    }
}
