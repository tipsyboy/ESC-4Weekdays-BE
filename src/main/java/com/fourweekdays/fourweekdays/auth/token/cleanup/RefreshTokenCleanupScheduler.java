package com.fourweekdays.fourweekdays.auth.token.cleanup;

import com.fourweekdays.fourweekdays.auth.token.manager.RefreshTokenManager;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class RefreshTokenCleanupScheduler {

    private final RefreshTokenManager refreshTokenManager;

    @Scheduled(cron = "0 0 * * * *")
    public void cleanupExpiredRefreshTokens() {
        refreshTokenManager.deleteExpiredTokens();
    }
}
