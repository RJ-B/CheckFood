package com.checkfood.checkfoodservice.security.module.auth.controller;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.*;
import com.checkfood.checkfoodservice.security.module.auth.dto.request.*;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.UserResponse;
import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.TimeUnit;

/**
 * REST kontroler pro autentizaci a správu uživatelských účtů.
 * Poskytuje endpointy pro registraci, přihlášení, verifikaci emailu a správu tokenů.
 * Všechny veřejné endpointy jsou chráněny rate limitingem proti zneužití.
 *
 * @see AuthService
 * @see RateLimited
 */
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    /**
     * Registruje nového uživatele a zasílá verifikační email.
     * Rate limit: max 5 registrací za 15 minut z jedné IP adresy.
     *
     * @param request registrační data včetně emailu, hesla a jména
     * @return HTTP 202 Accepted po úspěšné registraci
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
        authService.register(request);
        return ResponseEntity.accepted().build();
    }

    /**
     * Znovu odešle verifikační email pro neověřený účet.
     * Rate limit: max 3 pokusy za 5 minut z jedné IP adresy pro prevenci spamování.
     *
     * @param request obsahuje email účtu, pro který má být kód znovu odeslán
     * @return HTTP 200 OK po úspěšném odeslání
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
        authService.resendVerificationCode(request.getEmail());
        return ResponseEntity.ok().build();
    }

    /**
     * Zpracovává verifikaci účtu prostřednictvím tokenu z emailu.
     * Přesměruje uživatele do mobilní aplikace s výsledkem verifikace.
     * V případě úspěchu přesměruje na checkfood://app/login?status=success,
     * při chybě na checkfood://app/login?status=error&message=encoded_error_message.
     *
     * @param token verifikační token z emailového odkazu
     * @param response HTTP odpověď pro přesměrování
     * @throws IOException při chybě přesměrování
     */
    @GetMapping("/verify")
    public void verifyAccount(@RequestParam("token") String token, HttpServletResponse response) throws IOException {
        try {
            authService.verifyAccount(token);
            response.sendRedirect("checkfood://app/login?status=success");
        } catch (Exception e) {
            String encodedMessage = URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8);
            response.sendRedirect("checkfood://app/login?status=error&message=" + encodedMessage);
        }
    }

    /**
     * Přihlásí uživatele a vrátí autentizační tokeny.
     * Rate limit: max 10 pokusů za minutu z jedné IP adresy.
     *
     * @param request přihlašovací údaje (email a heslo)
     * @return autentizační odpověď obsahující access token, refresh token a informace o uživateli
     */
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

    /**
     * Obnoví platnost access tokenu pomocí refresh tokenu.
     *
     * @param request obsahuje refresh token
     * @return nový access token a refresh token
     */
    @PostMapping("/refresh")
    public ResponseEntity<TokenResponse> refreshToken(@Valid @RequestBody RefreshRequest request) {
        return ResponseEntity.ok(authService.refreshToken(request));
    }

    /**
     * Odhlásí uživatele a invaliduje jeho tokeny.
     *
     * @param request obsahuje refresh token k invalidaci
     * @return HTTP 204 No Content po úspěšném odhlášení
     */
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@Valid @RequestBody LogoutRequest request) {
        authService.logout(request);
        return ResponseEntity.noContent().build();
    }

    /**
     * Vrátí informace o aktuálně přihlášeném uživateli.
     *
     * @param userDetails autentizační detaily z Security Contextu
     * @return informace o uživateli (ID, email, jméno, role)
     */
    @GetMapping("/me")
    public ResponseEntity<UserResponse> getCurrentUser(@AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(authService.getCurrentUser(userDetails));
    }
}