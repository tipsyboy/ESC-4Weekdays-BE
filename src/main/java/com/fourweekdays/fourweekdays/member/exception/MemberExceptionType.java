package com.fourweekdays.fourweekdays.member.exception;

import com.fourweekdays.fourweekdays.global.exception.ExceptionType;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.NOT_FOUND;

public enum MemberExceptionType implements ExceptionType {

    MEMBER_NOT_FOUND(NOT_FOUND, "해당 직원을 찾을 수 없습니다."),
    DUPLICATE_EMAIL(HttpStatus.CONFLICT, "이미 가입된 이메일입니다."),
    DUPLICATE_LOGIN_ID(HttpStatus.CONFLICT, "이미 사용 중인 로그인 ID입니다."),
    DUPLICATE_MEMBER_CODE(HttpStatus.CONFLICT, "이미 사용 중인 멤버 코드입니다."),
    INVALID_LOGIN_ID_FORMAT(HttpStatus.BAD_REQUEST, "로그인 ID 형식이 역할과 맞지 않습니다."),
    INVALID_VENDOR_MAPPING(HttpStatus.BAD_REQUEST, "권한과 업체 연결 조건이 올바르지 않습니다."),
    VENDOR_NOT_FOUND(NOT_FOUND, "연결할 업체를 찾을 수 없습니다.");

    private final HttpStatus httpStatus;
    private final String message;

    MemberExceptionType(HttpStatus httpStatus, String message) {
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
