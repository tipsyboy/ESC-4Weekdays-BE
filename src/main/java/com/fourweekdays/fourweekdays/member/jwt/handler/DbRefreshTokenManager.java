package com.fourweekdays.fourweekdays.member.jwt.handler;

import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.model.entity.RefreshToken;
import com.fourweekdays.fourweekdays.member.repository.RefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@RequiredArgsConstructor
@Component
public class DbRefreshTokenManager implements RefreshTokenManager {

    private static final Long REFRESH_TOKEN_EXPIRE_TIME = 7 * 24 * 60 * 60 * 1000L; // 7일

    private final RefreshTokenRepository refreshTokenRepository;

    @Override
    @Transactional
    public void saveRefreshToken(Member member, String refreshToken) {
        LocalDateTime expiryDate = LocalDateTime.now().plusSeconds(REFRESH_TOKEN_EXPIRE_TIME / 1000);

        RefreshToken token = RefreshToken.builder()
                .member(member)
                .token(refreshToken)
                .expiredAt(expiryDate)
                .build();

        refreshTokenRepository.save(token);
    }

    // TODO: 이후 구현
    @Override
    @Transactional(readOnly = true)
    public boolean isValidRefreshToken(String token, String username) {
//        RefreshToken refreshToken = refreshTokenRepository.findByToken(token)
//                .orElse(null);
//
//        if (refreshToken == null) {
//            return false;
//        }
//
//        if (!refreshToken.isValid()) {
//            return false;
//        }
//
//        return refreshToken.getMember().getUsername().equals(username);
        return true;
    }

    // TODO: 이후 구현
    @Override
    @Transactional
    public void revokeRefreshToken(String token) {
        refreshTokenRepository.deleteByToken(token);
    }
}