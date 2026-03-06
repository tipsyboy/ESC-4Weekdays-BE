package com.fourweekdays.fourweekdays.auth.service;

import com.fourweekdays.fourweekdays.auth.dto.TokenDto;
import com.fourweekdays.fourweekdays.auth.jwt.JwtTokenProvider;
import com.fourweekdays.fourweekdays.auth.token.manager.RefreshTokenManager;
import com.fourweekdays.fourweekdays.member.model.entity.MemberRole;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final JwtTokenProvider tokenProvider;
    private final RefreshTokenManager refreshTokenManager;

    @Transactional
    public TokenDto reissue(String refreshToken) {
        // 1. 리프레시 토큰에서 정보 추출
        String email = tokenProvider.getUsernameFromRefreshToken(refreshToken);
        String roleStr = tokenProvider.getRoleFromRefreshToken(refreshToken);
        MemberRole role = MemberRole.valueOf(roleStr);

        // JWT 서명만 맞는 게 아니라 우리 DB에도 유저의 토큰으로 등록되어 있는지 확인
        if (!refreshTokenManager.matches(refreshToken, email)) {
            // 이 예외는 Controller의 GlobalExceptionHandler나 에러 처리 로직에서 401로 받게 됩니다.
            throw new RuntimeException("유효하지 않은 인증 정보입니다. 다시 로그인해주세요.");
        }

        // 2. 새로운 토큰 세트 생성
        String newAccessToken = tokenProvider.createAccessToken(email, role);
        String newRefreshToken = tokenProvider.createRefreshToken(email, role);

        // 3. DB(또는 Redis)의 리프레시 토큰 업데이트 (로테이션)
        refreshTokenManager.updateRefreshToken(email, newRefreshToken);

        return new TokenDto(newAccessToken, newRefreshToken);
    }
}
