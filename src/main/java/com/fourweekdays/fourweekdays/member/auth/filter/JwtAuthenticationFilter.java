package com.fourweekdays.fourweekdays.member.auth.filter;


import com.fourweekdays.fourweekdays.member.jwt.JwtExceptionType;
import com.fourweekdays.fourweekdays.member.jwt.JwtTokenProvider;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.SecurityException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    public static final String ACCESS_TOKEN_COOKIE_NAME = "AT_LOGIN";

    private final JwtTokenProvider jwtTokenProvider;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        String token = resolveToken(request);
        try {
            if (StringUtils.hasText(token) && jwtTokenProvider.isValidAccessToken(token)) {
                // 토큰이 있는 경우에 토큰을 통해서 인증 정보 객체인 Authentication 객체를 만든다.
                // 이때 getAuthentication()에서 토큰을 파싱하는 부분이 있는데, 토큰에 문제가 있는 경우 예외가 발생한다.
                Authentication authentication = jwtTokenProvider.getAuthentication(token);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        } catch (SecurityException e) {
            request.setAttribute("exception", JwtExceptionType.INVALID_TOKEN.getCode());
            log.error("잘못된 JWT 서명입니다. SecurityException={}", token); // io.jsonwebtoken.security.SecurityException 여기 Exception 을 잘 모르겠다.
        } catch (MalformedJwtException e) {
            request.setAttribute("exception", JwtExceptionType.INVALID_TOKEN.getCode());
            log.error("잘못된 JWT 서명입니다. MalformedJwtException={}", token);
        } catch (ExpiredJwtException e) {
            request.setAttribute("exception", JwtExceptionType.EXPIRED_TOKEN.getCode());
            log.error("이미 만료된 토큰입니다. ExpiredJwtException={}", token);
        } catch (UnsupportedJwtException e) {
            request.setAttribute("exception", JwtExceptionType.UNSUPPORTED_TOKEN.getCode());
            log.error("지원하지 않는 토큰입니다. UnsupportedJwtException={}", token);
        } catch (IllegalArgumentException e) {
            request.setAttribute("exception", JwtExceptionType.INVALID_TOKEN.getCode());
            log.error("토큰이 잘못되었습니다. IllegalArgumentException={}", token);
        }

        filterChain.doFilter(request, response);
    }

    private String resolveToken(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();

        // TODO: jwt 허용된 토큰만 찾는 메서드로 분리?
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (ACCESS_TOKEN_COOKIE_NAME.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}

