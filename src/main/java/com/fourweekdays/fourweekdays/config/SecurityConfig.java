package com.fourweekdays.fourweekdays.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fourweekdays.fourweekdays.asn.filter.VendorApiKeyFilter;
import com.fourweekdays.fourweekdays.member.config.filter.JwtAuthFilter;
import com.fourweekdays.fourweekdays.member.config.filter.LoginFilter;
import com.fourweekdays.fourweekdays.member.config.handler.CustomLogoutSuccessHandler;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private static final String LOGIN_URL = "/api/login";
    private static final String[] API_WHITE_LIST = {
            "/api/ans/**",
            "/api/member/**"
    };

    private final AuthenticationConfiguration configuration;
    private final ObjectMapper objectMapper;

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowCredentials(true);
        configuration.setAllowedOrigins(List.of(
                "http://localhost:5173",
                "https://www.fourweeeek.kro.kr"
        ));
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("*"));

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

    @Bean
    public SecurityFilterChain configure(HttpSecurity http, VendorApiKeyFilter vendorApiKeyFilter) throws Exception {
        http.authorizeHttpRequests(
                (auth) -> auth
                        .requestMatchers(API_WHITE_LIST).permitAll()
                        .anyRequest().permitAll()
        );

        http.cors(cors ->
                cors.configurationSource(corsConfigurationSource()));

        http.csrf(AbstractHttpConfigurer::disable);
        http.httpBasic(AbstractHttpConfigurer::disable);
        http.formLogin(AbstractHttpConfigurer::disable);

        http.logout(logout -> logout
                .logoutUrl("/api/logout")
                .deleteCookies("4weekdays")
                .logoutSuccessHandler(new CustomLogoutSuccessHandler(objectMapper))
        );

        http.addFilterBefore(vendorApiKeyFilter, UsernamePasswordAuthenticationFilter.class);
        http.addFilterBefore(new JwtAuthFilter(), UsernamePasswordAuthenticationFilter.class);
        http.addFilterAt(
                new LoginFilter(configuration.getAuthenticationManager(), LOGIN_URL),
                UsernamePasswordAuthenticationFilter.class
        );

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
