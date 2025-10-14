package com.fourweekdays.fourweekdays.vendor.exception;

import com.fourweekdays.fourweekdays.global.exception.BaseException;
import com.fourweekdays.fourweekdays.global.exception.ExceptionType;

public class VendorException extends BaseException {

    public VendorException(ExceptionType exceptionType) {
        super(exceptionType);
    }
}
