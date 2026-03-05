package com.fourweekdays.fourweekdays.member.jwt.handler;

import com.fourweekdays.fourweekdays.member.model.entity.Member;

public interface RefreshTokenManager {

    void saveRefreshToken(Member member, String refreshToken);

    boolean isValidRefreshToken(String token, String username);

    void revokeRefreshToken(String token);

}
