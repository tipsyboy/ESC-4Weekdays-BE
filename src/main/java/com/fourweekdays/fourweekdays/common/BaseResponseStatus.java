package com.fourweekdays.fourweekdays.common;

import lombok.Getter;

/**
 * 에러 코드 관리
 */
@Getter
public enum BaseResponseStatus {
     /**
     * 20000 : 요청 성공
     */
    SUCCESS(true, 20000, "요청에 성공하였습니다."),
    SUCCESS_UPDATE(true, 20001, "수정에 성공하였습니다."),

    /**
     * 30000 : Request 오류
     */


    /**
     * 40000 : Response 오류
     */
    NOT_FOUND(false, 40000, "찾을 수 없는 리소스입니다."),
    PRODUCT_NOT_FOUND(false, 40001, "해당 상품을 찾을 수 없습니다."),
    INVALID_TOKEN(false, 40002, "유효하지 않은 토큰입니다."),


    /**
     * 50000 : Database, Server 오류
     */
    SERVER_ERROR(false, 50000, "서버 내부 오류가 발생했습니다.");

    private final boolean isSuccess;
    private final int code;
    private final String message;

    private BaseResponseStatus(boolean isSuccess, int code, String message) {
        this.isSuccess = isSuccess;
        this.code = code;
        this.message = message;
    }
}
