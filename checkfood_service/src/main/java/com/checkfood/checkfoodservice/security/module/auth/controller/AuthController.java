package com.checkfood.checkfoodservice.security.module.auth.controller;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.*;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.module.auth.dto.response.TokenResponse;
import com.checkfood.checkfoodservice.security.module.auth.repository.PasswordResetTokenRepository;
import com.checkfood.checkfoodservice.security.module.user.dto.response.UserResponse;
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
import java.time.LocalDateTime;
import java.util.concurrent.TimeUnit;

/**
 * REST controller pro autentizaci a správu uživatelských účtů.
 *
 * Poskytuje HTTP API endpointy pro kompletní authentication workflow včetně
 * registrace, verifikace, přihlášení a session managementu. Implementuje
 * rate limiting pro security protection a deep link integration pro mobile app.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuthService
 * @see RateLimited
 */
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final PasswordResetTokenRepository passwordResetTokenRepository;

    /**
     * Registruje nového uživatele do systému s rate limiting protection.
     *
     * Asynchronní proces - vrací 202 Accepted protože registrace pokračuje
     * email verification workflow. Rate limiting 5 pokusů per 15 minut per IP.
     *
     * @param request validované registrační data
     * @return ResponseEntity s HTTP 202 status
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
     * Registruje nového majitele restaurace s rate limiting protection.
     *
     * @param request validované registrační data majitele
     * @return ResponseEntity s HTTP 202 status
     */
    @RateLimited(
            key = "auth:register-owner",
            limit = 5,
            duration = 15,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/register-owner")
    public ResponseEntity<Void> registerOwner(@Valid @RequestBody RegisterRequest request) {
        authService.registerOwner(request);
        return ResponseEntity.accepted().build();
    }

    /**
     * Znovu odešle verifikační email pro account activation.
     *
     * Rate limiting 3 pokusy per 5 minut per IP pro prevenci spam abuse.
     *
     * @param request request s email adresou
     * @return ResponseEntity s HTTP 200 status
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
     * Verifikuje účet přes email link a přesměrovává do mobile app.
     *
     * Implementuje deep link integration pro seamless UX - úspěch i chyby
     * jsou handleovány přes custom URL scheme pro Flutter app.
     *
     * @param token verification token z email linku
     * @param response HTTP response pro redirect functionality
     * @throws IOException při redirect failures
     */
    @RateLimited(key = "auth:verify", limit = 20, duration = 1, unit = TimeUnit.MINUTES, perIp = true)
    @GetMapping("/verify")
    public void verifyAccount(@RequestParam("token") String token, HttpServletResponse response) throws IOException {
        try {
            authService.verifyAccount(token);
            response.sendRedirect("checkfood://app/login?status=success");
        } catch (Exception e) {
            // Map to opaque error codes — never leak raw exception messages
            // to the deep-link URL (they might expose stack traces or token
            // details in edge cases). The mobile app renders a localized
            // string keyed on `type`.
            String errorType = "VERIFICATION_ERROR";
            if (e instanceof com.checkfood.checkfoodservice.security.module.auth.exception.AuthException authEx) {
                Object code = authEx.getErrorCode();
                if (code != null) {
                    errorType = code.toString();
                }
            }

            response.sendRedirect(String.format(
                    "checkfood://app/login?status=error&type=%s",
                    URLEncoder.encode(errorType, StandardCharsets.UTF_8)
            ));
        }
    }

    /**
     * Autentizuje uživatele a vytvoří JWT session tokens.
     *
     * Rate limiting 10 pokusů per minuta per IP pro brute force protection.
     *
     * @param request login credentials s optional device metadata
     * @return AuthResponse s JWT tokens a user profile
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
     * Obnovuje JWT access token pomocí refresh token.
     *
     * Rate limiting 30 pokusů per minuta per IP pro ochranu proti zneužití ukradeného tokenu.
     * Dodatečná security je zajištěna device binding validation v service layer.
     *
     * @param request refresh request s refresh token a device identifier
     * @return TokenResponse s novými JWT tokens
     */
    @RateLimited(
            key = "auth:refresh",
            limit = 30,
            duration = 1,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/refresh")
    public ResponseEntity<TokenResponse> refreshToken(@Valid @RequestBody RefreshRequest request) {
        return ResponseEntity.ok(authService.refreshToken(request));
    }

    /**
     * Odhlašuje uživatele a invaliduje session tokens.
     *
     * HTTP 204 No Content - successful logout bez response body.
     * Ověřuje, že refresh token patří přihlášenému uživateli (prevence logout hijack).
     *
     * @param request logout request s refresh token a device identifier
     * @param userDetails přihlášený uživatel z Security kontextu (může být null pro permitAll)
     * @return ResponseEntity s HTTP 204 status
     */
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(
            @Valid @RequestBody LogoutRequest request,
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        String email = (userDetails != null) ? userDetails.getUsername() : null;
        authService.logout(request, email);
        return ResponseEntity.noContent().build();
    }

    /**
     * Odešle email s odkazem pro obnovu hesla.
     * Vrací 200 OK vždy — i pro neexistující email (prevence user enumeration).
     *
     * @param request request s email adresou uživatele
     * @return ResponseEntity s HTTP 200 status
     */
    @RateLimited(
            key = "auth:forgot-password",
            limit = 3,
            duration = 15,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/forgot-password")
    public ResponseEntity<Void> forgotPassword(@Valid @RequestBody ForgotPasswordRequest request) {
        authService.requestPasswordReset(request.getEmail());
        return ResponseEntity.ok().build();
    }

    /**
     * GET endpoint pro deep link redirect z emailu.
     * Validuje token a přesměruje do mobilní aplikace přes custom URL scheme.
     *
     * @param token reset token z emailového odkazu
     * @param response HTTP response pro redirect functionality
     * @throws IOException při redirect failures
     */
    @GetMapping("/reset-password")
    public void resetPasswordRedirect(@RequestParam("token") String token, HttpServletResponse response) throws IOException {
        var optToken = passwordResetTokenRepository.findByToken(token);
        if (optToken.isEmpty() || optToken.get().isUsed() || optToken.get().getExpiryDate().isBefore(LocalDateTime.now())) {
            String msg = optToken.isEmpty() ? "Neplatný odkaz" :
                         optToken.get().isUsed() ? "Odkaz již byl použit" :
                         "Odkaz vypršel";
            response.sendRedirect(String.format(
                    "checkfood://app/login?status=error&type=RESET_TOKEN_ERROR&message=%s",
                    URLEncoder.encode(msg, StandardCharsets.UTF_8)
            ));
            return;
        }
        response.sendRedirect("checkfood://app/reset-password?token=" + token);
    }

    /**
     * Provede reset hesla na základě tokenu a nového hesla.
     *
     * @param request request s tokenem a novým heslem
     * @return ResponseEntity s HTTP 200 status
     */
    @RateLimited(
            key = "auth:reset-password",
            limit = 5,
            duration = 15,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/reset-password")
    public ResponseEntity<Void> resetPassword(@Valid @RequestBody ResetPasswordRequest request) {
        authService.resetPassword(request.getToken(), request.getNewPassword());
        return ResponseEntity.ok().build();
    }

    /**
     * Vrátí profil aktuálně přihlášeného uživatele.
     *
     * @param userDetails Spring Security principal z authentication contextu
     * @return UserResponse s daty uživatelského profilu
     */
    @GetMapping("/me")
    public ResponseEntity<UserResponse> getCurrentUser(@AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(authService.getCurrentUser(userDetails));
    }
}