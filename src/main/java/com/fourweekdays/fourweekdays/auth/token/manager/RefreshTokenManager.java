package com.fourweekdays.fourweekdays.auth.token.manager;

import com.fourweekdays.fourweekdays.member.domain.Member;

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
     * 특정 회원의 저장소 토큰을 취소하고 삭제
     */
    void revokeRefreshToken(Member member);

    /**
     * 토큰 재발급시 저장소 토큰을 새 토큰으로 변경
     */
    void updateRefreshToken(String email, String newRefreshToken);

    /**
     * 만료된 리프레시 토큰을 삭제
     */
    void deleteExpiredTokens();
}
