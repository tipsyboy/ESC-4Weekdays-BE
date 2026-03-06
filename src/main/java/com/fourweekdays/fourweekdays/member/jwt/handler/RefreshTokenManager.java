package com.fourweekdays.fourweekdays.member.jwt.handler;

import com.fourweekdays.fourweekdays.member.model.entity.Member;

public interface RefreshTokenManager {

    /**
     * 저장소에 리프레시 토큰을 저장
     */
    void saveRefreshToken(Member member, String refreshToken);

    /**
     * 저장소에 저장된 토큰과 소유자가 일치하는지 매칭
     */
    boolean matches(String token, String email);

    /**
     * 저장소에 저장된 토큰을 취소하고 삭제
     */
    void revokeRefreshToken(String token);

    /**
     * 토큰 재발급시 저장소 토큰을 새 토큰으로 변경
     */
    void updateRefreshToken(String email, String newRefreshToken);
}
