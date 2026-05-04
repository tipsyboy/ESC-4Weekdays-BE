package com.fourweekdays.fourweekdays.auth.token.repository;

import com.fourweekdays.fourweekdays.member.domain.Member;
import com.fourweekdays.fourweekdays.auth.token.entity.RefreshToken;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RefreshTokenRepository extends JpaRepository<RefreshToken, Long> {
    void deleteByToken(String token);

    void deleteByMember(Member member);

    Optional<RefreshToken> findByMember(Member member);

    Optional<RefreshToken> findByToken(String token);
}
