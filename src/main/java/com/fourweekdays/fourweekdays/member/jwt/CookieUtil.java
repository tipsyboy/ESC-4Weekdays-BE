package com.fourweekdays.fourweekdays.member.jwt;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseCookie;
import org.springframework.stereotype.Component;

@Component
public class CookieUtil {

    public static final String AT_COOKIE_NAME = "4weekdays_AT";
    public static final String RT_COOKIE_NAME = "4weekdays_RT";

    @Value("${cookie.secure}")
    private boolean isSecure;

    public ResponseCookie createCookie(String name, String value, long maxAge) {
        return ResponseCookie.from(name, value)
                .httpOnly(true)
                .secure(isSecure)
                .path("/")
                .maxAge(maxAge)
                .build();
    }
}