package com.fourweekdays.fourweekdays.global.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fourweekdays.fourweekdays.asn.filter.VendorApiKeyFilter;
import com.fourweekdays.fourweekdays.global.config.constant.SecurityConstants;
import com.fourweekdays.fourweekdays.auth.service.AuthService;
import com.fourweekdays.fourweekdays.auth.filter.JwtAuthenticationFilter;
import com.fourweekdays.fourweekdays.auth.filter.LoginFilter;
import com.fourweekdays.fourweekdays.auth.handler.CustomLogoutSuccessHandler;
import com.fourweekdays.fourweekdays.auth.jwt.CookieUtil;
import com.fourweekdays.fourweekdays.auth.jwt.JwtTokenProvider;
import com.fourweekdays.fourweekdays.auth.token.manager.RefreshTokenManager;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final ObjectMapper objectMapper;
    private final JwtTokenProvider jwtTokenProvider;
    private final AuthenticationConfiguration configuration;
    private final RefreshTokenManager refreshTokenManager;
    private final CookieUtil cookieUtil;
    private final AuthService authService;

    @Bean
    public SecurityFilterChain configure(HttpSecurity http, VendorApiKeyFilter vendorApiKeyFilter) throws Exception {
        http.authorizeHttpRequests(auth -> auth
                // 로그인 및 화이트리스트
                .requestMatchers(HttpMethod.POST, SecurityConstants.LOGIN_URL).permitAll()
                .requestMatchers(SecurityConstants.API_WHITE_LIST).permitAll()

                // 관리자 전용 (생성 / 수정 / 삭제)
                .requestMatchers(HttpMethod.POST, SecurityConstants.ADMIN_POST_LIST).hasRole("ADMIN")
                .requestMatchers(HttpMethod.PATCH, SecurityConstants.ADMIN_PATCH_LIST).hasRole("ADMIN")
                .requestMatchers(HttpMethod.DELETE, SecurityConstants.ADMIN_DELETE_LIST).hasRole("ADMIN")
                .requestMatchers(SecurityConstants.ADMIN_ONLY_LIST).hasRole("ADMIN")

                // WORKER 이상
                .requestMatchers(SecurityConstants.WORKER_LIST).hasAnyRole("ADMIN", "MANAGER", "WORKER")

                // MANAGER 이상 (GET)
                .requestMatchers(HttpMethod.GET, SecurityConstants.MANAGER_GET_LIST).hasAnyRole("ADMIN", "MANAGER")

                // 외부 API
                .requestMatchers(SecurityConstants.EXTERNAL_API_LIST).authenticated()

                // 나머지는 인증 필요
                .anyRequest().authenticated()
        );

        http.cors(Customizer.withDefaults());

        http.csrf(AbstractHttpConfigurer::disable);
        http.httpBasic(AbstractHttpConfigurer::disable);
        http.formLogin(AbstractHttpConfigurer::disable);

        http.logout(logout -> logout
                .logoutUrl("/api/logout")
                .deleteCookies("4weekdays")
                .logoutSuccessHandler(new CustomLogoutSuccessHandler(objectMapper, cookieUtil, refreshTokenManager))
        );

        http.addFilterBefore(vendorApiKeyFilter, UsernamePasswordAuthenticationFilter.class);
        http.addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider, cookieUtil, authService), UsernamePasswordAuthenticationFilter.class);
        http.addFilterAt(
                new LoginFilter(configuration.getAuthenticationManager(), objectMapper, jwtTokenProvider, cookieUtil),
                UsernamePasswordAuthenticationFilter.class
        );

        return http.build();
    }
}
