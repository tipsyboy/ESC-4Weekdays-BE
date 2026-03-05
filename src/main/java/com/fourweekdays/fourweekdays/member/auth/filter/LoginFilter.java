package com.fourweekdays.fourweekdays.member.auth.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.member.jwt.CookieUtil;
import com.fourweekdays.fourweekdays.member.jwt.JwtTokenProvider;
import com.fourweekdays.fourweekdays.member.auth.principal.LoginMember;
import com.fourweekdays.fourweekdays.member.model.dto.MemberLoginDto;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.io.IOException;
import java.util.Map;

@Slf4j
public class LoginFilter extends UsernamePasswordAuthenticationFilter {

    private static final String LOGIN_URI = "/api/login";

    private final AuthenticationManager authenticationManager;
    private final ObjectMapper objectMapper;
    private final JwtTokenProvider tokenProvider;
    private final CookieUtil cookieUtil;

    public LoginFilter(AuthenticationManager authenticationManager,
                       ObjectMapper objectMapper,
                       JwtTokenProvider tokenProvider,
                       CookieUtil cookieUtil) {
        this.authenticationManager = authenticationManager;
        this.objectMapper = objectMapper;
        this.tokenProvider = tokenProvider;
        this.cookieUtil = cookieUtil;
        setFilterProcessesUrl(LOGIN_URI);
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
        try {
            MemberLoginDto memberLoginDto = objectMapper.readValue(request.getInputStream(), MemberLoginDto.class);
            // Security 에서 검증을 위해 token 생성
            UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                    memberLoginDto.getEmail(),
                    memberLoginDto.getPassword(),
                    null
            );

            // AuthenticationManager에 token 검증을 위임
            return authenticationManager.authenticate(authToken);
        } catch (IOException e) {
            // 로그인 실패
            throw new AuthenticationException("로그인 실패") {
            };
        }
    }

    // 로그인 성공 - JWT 발급, 헤더에 쿠키 담기
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authentication) throws IOException {
        LoginMember loginMember = (LoginMember) authentication.getPrincipal();

        String accessToken = tokenProvider.createAccessToken(
                loginMember.getUsername(),
                loginMember.getMember().getRole()
        );

        String refreshToken = tokenProvider.createRefreshToken(
                loginMember.getUsername(),
                loginMember.getMember().getRole()
        );

        tokenProvider.saveRefreshToken(loginMember.getMember(), refreshToken);

        ResponseCookie accessTokenCookie = cookieUtil.createCookie("AT_LOGIN", accessToken, 30 * 60);
        ResponseCookie refreshTokenCookie = cookieUtil.createCookie("RT_LOGIN", refreshToken, 7 * 24 * 60 * 60);

        response.addHeader(HttpHeaders.SET_COOKIE, accessTokenCookie.toString());
        response.addHeader(HttpHeaders.SET_COOKIE, refreshTokenCookie.toString());
        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/json;charset=UTF-8");

        Map<String, Object> result = Map.of("role", loginMember.getMember().getRole().name());

        // 구버전처럼 BaseResponse 포맷에 맞춰서 바디를 내려줍니다.
        response.getWriter().write(objectMapper.writeValueAsString(BaseResponse.success(result)));
    }

    // 로그인 실패 -
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write("{\"message\":\"로그인 실패: " + failed.getMessage() + "\"}");
    }
}