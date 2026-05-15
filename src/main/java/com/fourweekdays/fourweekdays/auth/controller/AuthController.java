package com.fourweekdays.fourweekdays.auth.controller;

import com.fourweekdays.fourweekdays.auth.dto.AuthMeResponse;
import com.fourweekdays.fourweekdays.auth.dto.TokenDto;
import com.fourweekdays.fourweekdays.auth.jwt.CookieUtil;
import com.fourweekdays.fourweekdays.auth.jwt.TokenExpiration;
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

    // 현재 사용하지 않는 reissue API.
    // Refresh token 재발급은 JwtAuthenticationFilter에서 access token 만료 요청을 처리할 때 수행한다.
//    @PostMapping("/reissue")
    public ResponseEntity<BaseResponse<String>> reissue(@CookieValue(value = CookieUtil.RT_COOKIE_NAME, required = false) String refreshToken) {
        if (refreshToken == null || refreshToken.isBlank()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(BaseResponse.fail(HttpStatus.UNAUTHORIZED, "다시 로그인해주세요."));
        }

        TokenDto tokenDto = authService.reissue(refreshToken);
        ResponseCookie atCookie = cookieUtil.createCookie(CookieUtil.AT_COOKIE_NAME, tokenDto.getAccessToken(), TokenExpiration.ACCESS_COOKIE_SECONDS);
        ResponseCookie rtCookie = cookieUtil.createCookie(CookieUtil.RT_COOKIE_NAME, tokenDto.getRefreshToken(), TokenExpiration.REFRESH_COOKIE_SECONDS);

        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, atCookie.toString())
                .header(HttpHeaders.SET_COOKIE, rtCookie.toString())
                .body(BaseResponse.success("토큰 재발급 성공"));
    }
}
