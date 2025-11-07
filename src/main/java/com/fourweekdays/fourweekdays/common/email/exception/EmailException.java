package com.fourweekdays.fourweekdays.common.email.exception;

import com.fourweekdays.fourweekdays.global.exception.BaseException;
import com.fourweekdays.fourweekdays.global.exception.ExceptionType;

public class EmailException extends BaseException {

    public EmailException(ExceptionType exceptionType) {
        super(exceptionType);
    }
}
