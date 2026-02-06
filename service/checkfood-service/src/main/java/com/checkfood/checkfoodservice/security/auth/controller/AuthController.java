package com.checkfood.checkfoodservice.security.auth.controller;

import com.checkfood.checkfoodservice.security.auth.dto.request.*;
import com.checkfood.checkfoodservice.security.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.auth.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.auth.service.AuthService;
import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.TimeUnit;

@Slf4j
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    /**
     * Zaregistruje uživatele.
     * Rate limit: max 5 registrací za 15 minut z jedné IP.
     */
    @RateLimited(
            key = "auth:register",
            limit = 5,
            duration = 15,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/register")
    public ResponseEntity<Void> register(@Valid @RequestBody RegisterRequest request) {
        log.info("Registrace nového uživatele: {}", request.getEmail());
        authService.register(request);
        return ResponseEntity.accepted().build();
    }

    /**
     * Endpoint pro znovuzaslání verifikačního e-mailu.
     * Rate limit je zde přísnější (max 3 pokusy za 5 minut), aby se předešlo spamování.
     */
    @RateLimited(
            key = "auth:resend",
            limit = 3,
            duration = 5,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/resend-code")
    public ResponseEntity<Void> resendCode(@Valid @RequestBody ResendCodeRequest request) {
        log.info("Žádost o nový kód pro: {}", request.getEmail());
        authService.resendVerificationCode(request.getEmail());
        return ResponseEntity.ok().build();
    }

    /**
     * Zpracovává kliknutí na odkaz v e-mailu.
     * Přesměruje uživatele zpět do mobilní aplikace s výsledkem.
     */
    @GetMapping("/verify")
    public void verifyAccount(@RequestParam("token") String token, HttpServletResponse response) throws IOException {
        try {
            authService.verifyAccount(token);
            // Úspěch: Flutter aplikace zachytí status=success a automaticky přihlásí uživatele
            response.sendRedirect("checkfood://app/login?status=success");
        } catch (Exception e) {
            // Chyba (např. expirováno): Předáme zprávu v URL, Flutter ji zobrazí v SnackBaru
            String encodedMessage = URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8);
            response.sendRedirect("checkfood://app/login?status=error&message=" + encodedMessage);
        }
    }

    @RateLimited(
            key = "auth:login",
            limit = 10,
            duration = 1,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @PostMapping("/refresh")
    public ResponseEntity<TokenResponse> refreshToken(@Valid @RequestBody RefreshRequest request) {
        return ResponseEntity.ok(authService.refreshToken(request));
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@Valid @RequestBody LogoutRequest request) {
        authService.logout(request);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/me")
    public ResponseEntity<UserResponse> getCurrentUser(@AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(authService.getCurrentUser(userDetails));
    }
}