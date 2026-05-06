//package com.fourweekdays.fourweekdays.member.jwt;
//
//import com.fourweekdays.fourweekdays.member.model.entity.Member;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.redisson.api.RBucket;
//import org.redisson.api.RedissonClient;
//import org.springframework.stereotype.Component;
//
//import java.time.Duration;
//
//
//@Slf4j
//@RequiredArgsConstructor
//@Component
//public class RedisRefreshTokenManager implements RefreshTokenManager {
//
//    private static final long REFRESH_TOKEN_EXPIRE_TIME = TokenExpiration.REFRESH_COOKIE_SECONDS;
//    private static final String REFRESH_TOKEN_PREFIX = "RT:";
//
//    private final RedissonClient redissonClient;
//
//    @Override
//    public void saveRefreshToken(Member member, String refreshToken) {
//        String key = REFRESH_TOKEN_PREFIX + refreshToken;
//        RBucket<String> bucket = redissonClient.getBucket(key);
//
//        log.info("RedisRefreshTokenManager 사용 중");
//        bucket.set(member.getEmail(), Duration.ofSeconds(REFRESH_TOKEN_EXPIRE_TIME));
//    }
//
//    @Override
//    public boolean isValidRefreshToken(String token, String username) {
//        String key = REFRESH_TOKEN_PREFIX + token;
//        RBucket<String> bucket = redissonClient.getBucket(key);
//        String storedUsername = bucket.get();
//
//        return storedUsername != null && storedUsername.equals(username);
//    }
//
//    @Override
//    public void revokeRefreshToken(String token) {
//        String key = REFRESH_TOKEN_PREFIX + token;
//        RBucket<String> bucket = redissonClient.getBucket(key);
//        bucket.delete();
//    }
//}
