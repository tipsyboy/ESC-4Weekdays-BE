package com.fourweekdays.fourweekdays.member.jwt.handler;

import com.fourweekdays.fourweekdays.member.exception.MemberException;
import com.fourweekdays.fourweekdays.member.exception.MemberExceptionType;
import com.fourweekdays.fourweekdays.member.jwt.JwtExceptionType;
import com.fourweekdays.fourweekdays.member.model.entity.Member;
import com.fourweekdays.fourweekdays.member.model.entity.RefreshToken;
import com.fourweekdays.fourweekdays.member.repository.MemberRepository;
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
    private final MemberRepository memberRepository;

    @Override
    @Transactional
    public void saveRefreshToken(Member member, String refreshToken) {
        refreshTokenRepository.deleteByMember(member); // 중복 방지

        LocalDateTime expiryDate = LocalDateTime.now().plusSeconds(REFRESH_TOKEN_EXPIRE_TIME / 1000);
        RefreshToken token = RefreshToken.builder()
                .member(member)
                .token(refreshToken)
                .expiredAt(expiryDate)
                .build();

        refreshTokenRepository.save(token);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean matches(String token, String email) {

        return refreshTokenRepository.findByToken(token)
                .map(rt -> {
                    boolean isNotExpired = !rt.isExpired(); // 만료 확인
                    boolean isOwner = rt.getMember().getEmail().equals(email); // 소유자 확인
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
    public void updateRefreshToken(String email, String newRefreshToken) {
        Member member = memberRepository.findByEmail(email)
                .orElseThrow(() -> new MemberException(MemberExceptionType.MEMBER_NOT_FOUND));

        // TODO: RefreshTokenException 정의?
        RefreshToken refreshToken = refreshTokenRepository.findByMember(member)
                .orElseThrow(() -> new IllegalArgumentException(JwtExceptionType.NOT_FOUND_TOKEN.getMessage()));

        refreshToken.updateToken(newRefreshToken, LocalDateTime.now().plusSeconds(REFRESH_TOKEN_EXPIRE_TIME / 1000));
    }
}