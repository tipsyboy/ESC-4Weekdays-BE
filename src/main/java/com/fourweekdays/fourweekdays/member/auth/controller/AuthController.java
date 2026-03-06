package com.fourweekdays.fourweekdays.member.auth.controller;

import com.fourweekdays.fourweekdays.common.BaseResponse;
import com.fourweekdays.fourweekdays.member.jwt.CookieUtil;
import com.fourweekdays.fourweekdays.member.jwt.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RequestMapping("/api/auth")
@RequiredArgsConstructor
@RestController
public class AuthController {

    private final JwtTokenProvider tokenProvider;
    private final CookieUtil cookieUtil;
    private final AuthService authService;

    @PostMapping("/reissue")
    public ResponseEntity<BaseResponse<String>> reissue(@CookieValue(value = CookieUtil.RT_COOKIE_NAME, required = false) String refreshToken) {
        // 1. 유효성 검사
        if (refreshToken == null || !tokenProvider.isValidRefreshToken(refreshToken)) {
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
}
