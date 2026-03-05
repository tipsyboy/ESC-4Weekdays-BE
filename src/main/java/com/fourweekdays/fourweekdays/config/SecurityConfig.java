package com.fourweekdays.fourweekdays.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fourweekdays.fourweekdays.asn.filter.VendorApiKeyFilter;
import com.fourweekdays.fourweekdays.member.auth.handler.CustomLogoutSuccessHandler;
import com.fourweekdays.fourweekdays.member.auth.filter.JwtAuthenticationFilter;
import com.fourweekdays.fourweekdays.member.jwt.CookieUtil;
import com.fourweekdays.fourweekdays.member.jwt.JwtTokenProvider;
import com.fourweekdays.fourweekdays.member.auth.filter.LoginFilter;
import com.fourweekdays.fourweekdays.member.jwt.handler.RefreshTokenManager;
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

    private static final String LOGIN_URL = "/api/login";
    private static final String[] API_WHITE_LIST = {
            "/api/asn/**",
            "/api/vendor/asn/**",
            "/api/actuator/**"
    };

    private static final String[] ADMIN_POST_LIST = {
            "/api/announcement", "/api/franchises", "/api/products",
            "/api/vendors", "/api/warehouses", "/api/category",
            "/api/member/signup", "/api/purchase-orders"
    };

    private static final String[] ADMIN_PATCH_LIST = {
            "/api/announcement/**", "/api/franchises/**", "/api/products/**",
            "/api/vendors/**", "/api/warehouses/**", "/api/member/**",
            "/api/inbounds/**", "/api/outbounds/**", "/api/purchase-orders/**"
    };

    private static final String[] ADMIN_DELETE_LIST = {
            "/api/announcement/**", "/api/franchises/**", "/api/products/**",
            "/api/vendors/**", "/api/warehouses/**", "/api/inbounds/**",
            "/api/purchase-orders/**"
    };

    private static final String[] ADMIN_ONLY_LIST = {
            "/api/admin/**"
    };

    private static final String[] WORKER_LIST = {
            "/api/tasks/**", "/api/inbound-tasks/**"
    };

    private static final String[] MANAGER_GET_LIST = {
            "/api/announcement/**", "/api/franchises/**", "/api/products/**",
            "/api/vendors/**", "/api/warehouses/**", "/api/category/**",
            "/api/member/**", "/api/purchase-orders/**", "/api/inbounds/**",
            "/api/outbounds/**", "/api/inventories/**", "/api/locations/**"
    };

    private static final String[] EXTERNAL_API_LIST = {
            "/api/vendor/asn/**", "/api/franchise/order/**"
    };

    private final ObjectMapper objectMapper;
    private final JwtTokenProvider jwtTokenProvider;
    private final AuthenticationConfiguration configuration;
    private final RefreshTokenManager refreshTokenManager;
    private final CookieUtil cookieUtil;

    @Bean
    public SecurityFilterChain configure(HttpSecurity http, VendorApiKeyFilter vendorApiKeyFilter) throws Exception {
        http.authorizeHttpRequests(auth -> auth
                // 로그인 및 화이트리스트
                .requestMatchers(HttpMethod.POST, LOGIN_URL).permitAll()
                .requestMatchers(API_WHITE_LIST).permitAll()

                // 관리자 전용 (생성 / 수정 / 삭제)
                .requestMatchers(HttpMethod.POST, ADMIN_POST_LIST).hasRole("ADMIN")
                .requestMatchers(HttpMethod.PATCH, ADMIN_PATCH_LIST).hasRole("ADMIN")
                .requestMatchers(HttpMethod.DELETE, ADMIN_DELETE_LIST).hasRole("ADMIN")
                .requestMatchers(ADMIN_ONLY_LIST).hasRole("ADMIN")

                // WORKER 이상
                .requestMatchers(WORKER_LIST).hasAnyRole("ADMIN", "MANAGER", "WORKER")

                // MANAGER 이상 (GET)
                .requestMatchers(HttpMethod.GET, MANAGER_GET_LIST).hasAnyRole("ADMIN", "MANAGER")

                // 외부 API
                .requestMatchers(EXTERNAL_API_LIST).authenticated()

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
        http.addFilterBefore(new JwtAuthenticationFilter(jwtTokenProvider), UsernamePasswordAuthenticationFilter.class);
        http.addFilterAt(
                new LoginFilter(configuration.getAuthenticationManager(), objectMapper, jwtTokenProvider, cookieUtil),
                UsernamePasswordAuthenticationFilter.class
        );

        return http.build();
    }
}
