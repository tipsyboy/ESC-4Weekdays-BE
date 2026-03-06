package com.fourweekdays.fourweekdays.member.auth.controller;

import lombok.Getter;

@Getter
public class TokenDto {

    private final String accessToken;
    private final String refreshToken;

    public TokenDto(String accessToken, String refreshToken) {
        this.accessToken = accessToken;
        this.refreshToken = refreshToken;
    }
}