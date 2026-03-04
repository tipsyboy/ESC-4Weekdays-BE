package com.fourweekdays.fourweekdays.member.model.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

//@Table(indexes = @Index(name = "idx_token", columnList = "token"))
@Getter @NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class RefreshToken {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id", nullable = false)
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
