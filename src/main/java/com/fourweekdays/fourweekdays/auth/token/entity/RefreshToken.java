package com.fourweekdays.fourweekdays.auth.token.entity;

import com.fourweekdays.fourweekdays.member.model.entity.Member;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Table(name = "refresh_token", indexes = {
        @Index(name = "idx_token", columnList = "token"), // 토큰으로 조회
        @Index(name = "idx_member_id", columnList = "member_id") // 유저별 조회
})
@Getter @NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class RefreshToken {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", unique = true)
    private Member member;

    @Column(nullable = false)
    private String token;

    @Column(nullable = false)
    private LocalDateTime expiredAt;

    @Builder
    public RefreshToken(Member member, String token, LocalDateTime expiredAt) {
        this.member = member;
        this.token = token;
        this.expiredAt = expiredAt;
    }

    public void updateToken(String newToken, LocalDateTime newExpiredAt) {
        this.token = newToken;
        this.expiredAt = newExpiredAt;
    }

    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiredAt);
    }
}
