package com.fourweekdays.fourweekdays.member.auth.handler;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.member.jwt.CookieUtil;
import com.fourweekdays.fourweekdays.member.jwt.handler.RefreshTokenManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import java.io.IOException;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

    private final ObjectMapper objectMapper;
    private final CookieUtil cookieUtil;
    private final RefreshTokenManager refreshTokenManager;

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response,
                                Authentication authentication) throws IOException, ServletException {

        String refreshToken = resolveToken(request);
        if (refreshToken != null) {
            refreshTokenManager.revokeRefreshToken(refreshToken);
        }

        response.addHeader(HttpHeaders.SET_COOKIE, cookieUtil.createCookie(CookieUtil.AT_COOKIE_NAME, "", 0).toString());
        response.addHeader(HttpHeaders.SET_COOKIE, cookieUtil.createCookie(CookieUtil.RT_COOKIE_NAME, "", 0).toString());

        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/json; charset=UTF-8");

        BaseResponse<Map<String, Object>> logout = BaseResponse.success(Map.of(
                "message", "로그아웃에 성공하였습니다."
        ));

        objectMapper.writeValue(response.getWriter(), logout);
    }

    private String resolveToken(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("RT_LOGIN".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
}