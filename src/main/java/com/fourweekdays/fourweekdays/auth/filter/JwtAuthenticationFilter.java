package com.fourweekdays.fourweekdays.auth.filter;


import com.fourweekdays.fourweekdays.auth.service.AuthService;
import com.fourweekdays.fourweekdays.auth.dto.TokenDto;
import com.fourweekdays.fourweekdays.auth.jwt.CookieUtil;
import com.fourweekdays.fourweekdays.auth.exception.JwtExceptionType;
import com.fourweekdays.fourweekdays.auth.jwt.JwtTokenProvider;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.SecurityException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenProvider jwtTokenProvider;
    private final CookieUtil cookieUtil;
    private final AuthService authService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String accessToken = cookieUtil.getCookieValue(request, CookieUtil.AT_COOKIE_NAME);
        try {
            if (StringUtils.hasText(accessToken) && jwtTokenProvider.isValidAccessToken(accessToken)) {
                setAuthentication(accessToken);
            }
        } catch (ExpiredJwtException e) {
            log.info("Access Token 만료됨. 재발급 시도 중...");
            handleReissue(request, response);
        }
        catch (Exception e) {
            SecurityContextHolder.clearContext();
            handleJwtException(request, e, accessToken, "AT");
        }

        filterChain.doFilter(request, response);
    }

    private void handleReissue(HttpServletRequest request, HttpServletResponse response) {
        String refreshToken = cookieUtil.getCookieValue(request, CookieUtil.RT_COOKIE_NAME);

        if (!StringUtils.hasText(refreshToken)) {
            SecurityContextHolder.clearContext();
            return;
        }

        try {
            TokenDto tokenDto = authService.reissue(refreshToken);
            ResponseCookie accessTokenCookie = cookieUtil.createCookie(
                    CookieUtil.AT_COOKIE_NAME,
                    tokenDto.getAccessToken(),
                    30 * 60
            );
            ResponseCookie refreshTokenCookie = cookieUtil.createCookie(
                    CookieUtil.RT_COOKIE_NAME,
                    tokenDto.getRefreshToken(),
                    7 * 24 * 60 * 60
            );
            response.addHeader(HttpHeaders.SET_COOKIE, accessTokenCookie.toString());
            response.addHeader(HttpHeaders.SET_COOKIE, refreshTokenCookie.toString());
            setAuthentication(tokenDto.getAccessToken());
        } catch (Exception e) {
            SecurityContextHolder.clearContext();
            log.error("RefreshToken 재발급 실패 - 쿠키 삭제 처리");
            response.addHeader(HttpHeaders.SET_COOKIE, cookieUtil.createCookie(CookieUtil.AT_COOKIE_NAME, "", 0).toString());
            response.addHeader(HttpHeaders.SET_COOKIE, cookieUtil.createCookie(CookieUtil.RT_COOKIE_NAME, "", 0).toString());
            handleJwtException(request, e, refreshToken, "RT");
        }
    }

    private void setAuthentication(String token) {
        Authentication authentication = jwtTokenProvider.getAuthentication(token);
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    private void handleJwtException(HttpServletRequest request, Exception e, String token, String tokenType) {
        if (e instanceof SecurityException || e instanceof MalformedJwtException) {
            log.error("[{}] 잘못된 JWT 서명입니다. token={}", tokenType, token);
            request.setAttribute("exception", JwtExceptionType.INVALID_TOKEN.getCode());
        } else if (e instanceof UnsupportedJwtException) {
            log.error("[{}] 지원하지 않는 토큰입니다. token={}", tokenType, token);
            request.setAttribute("exception", JwtExceptionType.UNSUPPORTED_TOKEN.getCode());
        } else if (e instanceof IllegalArgumentException) {
            log.error("[{}] 토큰이 잘못되었습니다. token={}", tokenType, token);
            request.setAttribute("exception", JwtExceptionType.INVALID_TOKEN.getCode());
        } else if (e instanceof ExpiredJwtException) {
            log.error("[{}] 토큰이 만료되었습니다. token={}", tokenType, token);
            request.setAttribute("exception", JwtExceptionType.EXPIRED_TOKEN.getCode());
        } else { // 기타 정의되지 않은 예외
            log.error("[{}] 인증 처리 중 오류 발생: {}", tokenType, e.getMessage());
            request.setAttribute("exception", JwtExceptionType.INVALID_TOKEN.getCode());
        }
    }
}
