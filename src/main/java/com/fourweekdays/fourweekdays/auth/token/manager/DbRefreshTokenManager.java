package com.fourweekdays.fourweekdays.auth.token.manager;

import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.exception.MemberExceptionType;
import com.fourweekdays.fourweekdays.auth.exception.JwtExceptionType;
import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.auth.token.entity.RefreshToken;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
import com.fourweekdays.fourweekdays.auth.token.repository.RefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@RequiredArgsConstructor
@Component
public class DbRefreshTokenManager implements RefreshTokenManager {

    private static final Long REFRESH_TOKEN_EXPIRE_TIME = 7 * 24 * 60 * 60 * 1000L; // 7일

    private final RefreshTokenRepository refreshTokenRepository;
    private final MemberRepository memberRepository;

    @Override
    @Transactional
    public void saveRefreshToken(Member member, String refreshToken) {
        LocalDateTime expiryDate = LocalDateTime.now().plusSeconds(REFRESH_TOKEN_EXPIRE_TIME / 1000);
        refreshTokenRepository.findByMember(member)
                .ifPresentOrElse(
                        token -> token.updateToken(refreshToken, expiryDate),
                        () -> refreshTokenRepository.save(
                                RefreshToken.builder()
                                        .member(member)
                                        .token(refreshToken)
                                        .expiredAt(expiryDate)
                                        .build()
                        )
                );
    }

    @Override
    @Transactional(readOnly = true)
    public boolean matches(String token, String identifier) {

        return refreshTokenRepository.findByToken(token)
                .map(rt -> {
                    boolean isNotExpired = !rt.isExpired(); // 만료 확인
                    boolean isOwner = identifier.equals(rt.getMember().getEmail())
                            || identifier.equals(rt.getMember().getLoginId());
                    return isNotExpired && isOwner;
                })
                .orElse(false); // 토큰 없으면 false
    }

    @Override
    @Transactional
    public void revokeRefreshToken(String token) {
        refreshTokenRepository.deleteByToken(token);
    }

    @Override
    @Transactional
    public void revokeRefreshToken(Member member) {
        refreshTokenRepository.deleteByMember(member);
    }

    @Override
    @Transactional
    public void updateRefreshToken(String identifier, String newRefreshToken) {
        Member member = memberRepository.findByLoginIdOrEmail(identifier, identifier)
                .orElseThrow(() -> new MemberException(MemberExceptionType.MEMBER_NOT_FOUND));

        // TODO: RefreshTokenException 정의?
        RefreshToken refreshToken = refreshTokenRepository.findByMember(member)
                .orElseThrow(() -> new IllegalArgumentException(JwtExceptionType.NOT_FOUND_TOKEN.getMessage()));

        refreshToken.updateToken(newRefreshToken, LocalDateTime.now().plusSeconds(REFRESH_TOKEN_EXPIRE_TIME / 1000));
    }

    @Override
    @Transactional
    public void deleteExpiredTokens() {
        refreshTokenRepository.deleteByExpiredAtBefore(LocalDateTime.now());
    }
}
