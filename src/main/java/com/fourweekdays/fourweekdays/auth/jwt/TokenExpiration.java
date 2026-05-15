package com.fourweekdays.fourweekdays.auth.jwt;

public final class TokenExpiration {

    public static final long ACCESS_TOKEN_MILLIS = 30 * 60 * 1000L;
    public static final long REFRESH_TOKEN_MILLIS = 7 * 24 * 60 * 60 * 1000L;

    public static final long ACCESS_COOKIE_SECONDS = ACCESS_TOKEN_MILLIS / 1000;
    public static final long REFRESH_COOKIE_SECONDS = REFRESH_TOKEN_MILLIS / 1000;

    private TokenExpiration() {
    }
}
