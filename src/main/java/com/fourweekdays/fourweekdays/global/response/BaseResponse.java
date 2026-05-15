package com.fourweekdays.fourweekdays.global.response;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class BaseResponse<T> {
    private boolean success;
    private int code;
    private String message;
    private T results;

    public BaseResponse(boolean success, int code, String message, T results) {
        this.success = success;
        this.code = code;
        this.message = message;
        this.results = results;
    }

    public static <T> BaseResponse<T> success(T results) {
        return new BaseResponse<>(true, HttpStatus.OK.value(), "요청에 성공하였습니다.", results);
    }

    public static <T> BaseResponse<T> fail(HttpStatus httpStatus, String message) {
        return new BaseResponse<>(false, httpStatus.value(), message, null);
    }
}
