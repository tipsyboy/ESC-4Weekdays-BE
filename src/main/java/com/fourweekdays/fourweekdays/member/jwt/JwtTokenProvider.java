package com.fourweekdays.fourweekdays.member.jwt;



import com.fourweekdays.fourweekdays.member.model.entity.MemberRole;
import com.fourweekdays.fourweekdays.member.auth.service.MemberDetailsService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;

@Component
public class JwtTokenProvider {

    private static final Long ACCESS_TOKEN_EXPIRE_TIME = 30 * 60 * 1000L; // 30분
    private static final Long REFRESH_TOKEN_EXPIRE_TIME = 7 * 24 * 60 * 60 * 1000L; // 7일

    private final String accessSecretKey;
    private final String refreshSecretKey;
    private final MemberDetailsService memberDetailsService;

    public JwtTokenProvider(@Value("${jwt.secretKey}") String accessSecretKey,
                            @Value("${jwt.refreshKey}") String refreshSecretKey,
                            MemberDetailsService memberDetailsService) {
        this.accessSecretKey = accessSecretKey;
        this.refreshSecretKey = refreshSecretKey;
        this.memberDetailsService = memberDetailsService;
    }

    public String createAccessToken(String username, MemberRole role) {
        return createToken(username, role, ACCESS_TOKEN_EXPIRE_TIME, accessSecretKey);
    }

    public String createRefreshToken(String username, MemberRole role) {
        return createToken(username, role, REFRESH_TOKEN_EXPIRE_TIME, refreshSecretKey);
    }

    public boolean isValidAccessToken(String token) {
        return isValidToken(token, accessSecretKey);
    }

    public boolean isValidRefreshToken(String token) {
        return isValidToken(token, refreshSecretKey);
    }

    public String getUsernameFromToken(String token) {
        return parseClaims(token, accessSecretKey).getSubject();
    }

    public String getRoleFromToken(String token) {
        return parseClaims(token, accessSecretKey).get("role", String.class);
    }

    public Authentication getAuthentication(String token) {
        // 토큰과 시크릿 키를 사용해서 토큰 해석
        Claims claims = parseClaims(token, accessSecretKey);
        String role = claims.get("role", String.class);
        String username = claims.getSubject();

        Collection<? extends GrantedAuthority> authorities
                = Collections.singleton(new SimpleGrantedAuthority("ROLE_" + role));

        // TODO: 이후에 프로젝트 내부에서 사용하는 UserDetails 객체로 구조 변경?
        UserDetails userDetails = memberDetailsService.loadUserByUsername(username);
        return new UsernamePasswordAuthenticationToken(userDetails, "", authorities);
    }

    private String createToken(String username, MemberRole role, Long expiredTime, String secretKey) {
        Date now = new Date();
        Date expired = new Date(now.getTime() + expiredTime);
        // 다중 Role 처리
//        String authorities = authentication.getAuthorities().stream()
//                .map(GrantedAuthority::getAuthority)
//                .collect(Collectors.joining(","));

        return Jwts.builder()
                .setSubject(username)
                .claim("role", role.name())
                .setIssuedAt(now)
                .setExpiration(expired)
                .signWith(getSigningKey(secretKey), SignatureAlgorithm.HS256)
                .compact();
    }

    // JWT 유효성을 검증한다.
    private boolean isValidToken(String token, String secretKey) {
        Jwts.parserBuilder()
                .setSigningKey(getSigningKey(secretKey))
                .build()
                .parseClaimsJws(token); // 만약 유효한 토큰이 아닌 경우에 여기서 에러가 터짐
        // -> 그렇게되면, isValidToken()을 호출한 위치에서 리턴 값을 받는 대신에 예외를 받으니, 예외처리 해주면됨.

        return true; // 파싱이 이루어진 경우에는 문제가 없는 경우
    }

    private Claims parseClaims(String token, String secretKey) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(getSigningKey(secretKey))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e) {
            return e.getClaims();
        }
    }

    private Key getSigningKey(String secretKey) {
        byte[] bytes = secretKey.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(bytes);
    }

}

