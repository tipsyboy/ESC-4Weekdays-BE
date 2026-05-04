package com.fourweekdays.fourweekdays.auth.controller;

import com.fourweekdays.fourweekdays.auth.dto.AuthMeResponse;
import com.fourweekdays.fourweekdays.auth.dto.TokenDto;
import com.fourweekdays.fourweekdays.auth.jwt.CookieUtil;
import com.fourweekdays.fourweekdays.auth.principal.LoginMember;
import com.fourweekdays.fourweekdays.auth.service.AuthService;
import com.fourweekdays.fourweekdays.global.response.BaseResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.security.core.Authentication;


@RequestMapping("/api/auth")
@RequiredArgsConstructor
@RestController
public class AuthController {

    private final CookieUtil cookieUtil;
    private final AuthService authService;

    @GetMapping("/me")
    public ResponseEntity<BaseResponse<AuthMeResponse>> me(Authentication authentication) {
        return ResponseEntity.ok(BaseResponse.success(authService.me(authentication)));
    }

    @PostMapping("/reissue")
    public ResponseEntity<BaseResponse<String>> reissue(@CookieValue(value = CookieUtil.RT_COOKIE_NAME, required = false) String refreshToken) {
        // 1. 유효성 검사
        if (refreshToken == null || refreshToken.isBlank()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(BaseResponse.fail(HttpStatus.UNAUTHORIZED, "다시 로그인해주세요."));
        }

        // 2. 서비스 호출 (핵심 로직 실행)
        TokenDto tokenDto = authService.reissue(refreshToken);

        // 3. 응답 쿠키 생성 TODO: 매직넘버 처리하기
        ResponseCookie atCookie = cookieUtil.createCookie(CookieUtil.AT_COOKIE_NAME, tokenDto.getAccessToken(), 30 * 60);
        ResponseCookie rtCookie = cookieUtil.createCookie(CookieUtil.RT_COOKIE_NAME, tokenDto.getRefreshToken(), 7 * 24 * 60 * 60);

        // 4. 최종 응답
        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, atCookie.toString())
                .header(HttpHeaders.SET_COOKIE, rtCookie.toString())
                .body(BaseResponse.success("토큰 재발급 성공"));
    }

    @PostMapping("/logout")
    public ResponseEntity<BaseResponse<String>> logout(
            Authentication authentication,
            HttpServletRequest request,
            HttpServletResponse response
    ) {
        String refreshToken = cookieUtil.getCookieValue(request, CookieUtil.RT_COOKIE_NAME);
        authService.logout(authentication, refreshToken);
        response.addHeader(HttpHeaders.SET_COOKIE, cookieUtil.expireCookie(CookieUtil.AT_COOKIE_NAME).toString());
        response.addHeader(HttpHeaders.SET_COOKIE, cookieUtil.expireCookie(CookieUtil.RT_COOKIE_NAME).toString());
        return ResponseEntity.ok(BaseResponse.success("로그아웃 성공"));
    }
}
