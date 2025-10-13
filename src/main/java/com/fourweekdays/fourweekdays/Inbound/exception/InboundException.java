package com.fourweekdays.fourweekdays.Inbound.exception;

import com.fourweekdays.fourweekdays.global.exception.BaseException;
import com.fourweekdays.fourweekdays.global.exception.ExceptionType;

public class InboundException extends BaseException {

    public InboundException(ExceptionType exceptionType) {
        super(exceptionType);
    }
}
