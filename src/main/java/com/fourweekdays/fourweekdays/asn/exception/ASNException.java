package com.fourweekdays.fourweekdays.asn.exception;

import com.fourweekdays.fourweekdays.global.exception.BaseException;
import com.fourweekdays.fourweekdays.global.exception.ExceptionType;

public class ASNException extends BaseException {

    public ASNException(ExceptionType exceptionType) {
        super(exceptionType);
    }
}
