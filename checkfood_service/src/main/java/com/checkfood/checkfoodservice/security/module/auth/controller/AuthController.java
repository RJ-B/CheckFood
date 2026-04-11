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
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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
     * Verifikuje účet přes email link a vrátí HTML page.
     *
     * <p>HTML stránka:
     * <ul>
     *   <li>Pokud iOS / Android otevře link a má nainstalovanou CheckFood app,
     *       Universal Link / App Link otevře app přímo (řízeno
     *       {@code apple-app-site-association} a {@code assetlinks.json}
     *       v {@code WellKnownController}).</li>
     *   <li>Jinak (desktop, jiný telefon bez app, in-app browser, atd.)
     *       uživatel vidí pěknou success/error stránku s pokyny —
     *       místo Safari error o nemožném {@code checkfood://} scheme.</li>
     * </ul>
     *
     * <p>Tato cesta nahradila starší {@code response.sendRedirect("checkfood://...")},
     * která fungovala jen na zařízeních s nainstalovanou app a všude jinde
     * končila chybou v prohlížeči.</p>
     *
     * @param token verification token z email linku
     * @param response HTTP response (HTML body)
     * @throws IOException při zápisu odpovědi
     */
    @RateLimited(key = "auth:verify", limit = 20, duration = 1, unit = TimeUnit.MINUTES, perIp = true)
    @GetMapping(value = "/verify", produces = MediaType.TEXT_HTML_VALUE)
    public void verifyAccount(@RequestParam("token") String token, HttpServletResponse response) throws IOException {
        boolean success;
        String errorType = null;
        try {
            authService.verifyAccount(token);
            success = true;
        } catch (Exception e) {
            success = false;
            // Map to opaque error codes — don't leak raw exception messages.
            errorType = "VERIFICATION_ERROR";
            if (e instanceof com.checkfood.checkfoodservice.security.module.auth.exception.AuthException authEx) {
                Object code = authEx.getErrorCode();
                if (code != null) {
                    errorType = code.toString();
                }
            }
        }

        response.setContentType("text/html; charset=UTF-8");
        response.setStatus(HttpStatus.OK.value());
        response.getWriter().write(buildVerificationHtml(success, errorType));
    }

    private String buildVerificationHtml(boolean success, String errorType) {
        String title;
        String headline;
        String body;
        String emoji;
        String accent;
        // The success page exposes a deep-link button that opens the app via
        // the legacy `checkfood://` custom URL scheme. Once the project is
        // migrated to a paid Apple Developer Program (so that Universal Links
        // can be enabled — see ios/Runner/Runner.entitlements), Mail.app on
        // iOS will route the verification link directly to the app and this
        // intermediate HTML page will only be seen by desktop browsers and
        // by iOS Mail clients without the app installed. The button below is
        // therefore a UX bridge for the Personal-team build only — but it
        // also works fine as a permanent fallback for Android, desktop, and
        // any device that doesn't (or can't) handle the Universal Link.
        String actionButtonHtml = "";
        if (success) {
            title = "Účet ověřen — CheckFood";
            headline = "Účet úspěšně ověřen";
            body = "Tvůj účet je aktivovaný. Otevři aplikaci CheckFood a přihlas se.";
            emoji = "✓";
            accent = "#2ecc71";
            // The href triggers the existing Flutter custom-scheme handler
            // (FlutterDeepLinkingEnabled in Info.plist) → AppRouter case
            // login: → LoginPage(verificationStatus: 'success'). The status
            // value MUST stay in the whitelist defined in
            // checkfood_client/lib/navigation/app_router.dart line ~41.
            actionButtonHtml = "<a class=\"btn\" href=\"checkfood://app/login?status=success\">Otevřít CheckFood</a>"
                    + "<p class=\"hint\">Tlačítko otevře aplikaci, pokud ji máš nainstalovanou.</p>";
        } else {
            title = "Ověření selhalo — CheckFood";
            headline = "Ověření se nezdařilo";
            body = "Odkaz je neplatný nebo expiroval. Vyžádejte si nový kód v aplikaci."
                    + (errorType != null ? " (kód: " + errorType + ")" : "");
            emoji = "✕";
            accent = "#e74c3c";
            actionButtonHtml = "<a class=\"btn btn--ghost\" href=\"checkfood://app/login?status=expired\">Otevřít CheckFood</a>";
        }
        return "<!DOCTYPE html>\n<html lang=\"cs\"><head>"
                + "<meta charset=\"UTF-8\">"
                + "<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">"
                + "<title>" + title + "</title>"
                + "<style>"
                + "body{margin:0;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;"
                + "background:#0F2027;color:#fff;display:flex;align-items:center;justify-content:center;"
                + "min-height:100vh;padding:24px;text-align:center}"
                + ".card{background:#1e3540;border-radius:16px;padding:32px;max-width:420px;"
                + "box-shadow:0 8px 32px rgba(0,0,0,0.3)}"
                + ".icon{width:80px;height:80px;border-radius:50%;background:" + accent + ";"
                + "display:flex;align-items:center;justify-content:center;font-size:40px;"
                + "margin:0 auto 24px;font-weight:bold}"
                + "h1{margin:0 0 12px;font-size:22px;font-weight:600}"
                + "p{margin:0 0 8px;font-size:15px;line-height:1.5;opacity:0.85}"
                + ".btn{display:inline-block;margin-top:20px;padding:14px 28px;"
                + "background:" + accent + ";color:#0F2027;text-decoration:none;"
                + "border-radius:12px;font-weight:600;font-size:16px;"
                + "box-shadow:0 4px 16px rgba(0,0,0,0.25);transition:transform 0.15s}"
                + ".btn:active{transform:scale(0.97)}"
                + ".btn--ghost{background:transparent;color:#fff;border:1px solid rgba(255,255,255,0.3)}"
                + ".hint{margin-top:12px;font-size:12px;opacity:0.55}"
                + ".brand{margin-top:24px;font-size:13px;opacity:0.5;letter-spacing:1px}"
                + "</style></head><body>"
                + "<div class=\"card\">"
                + "<div class=\"icon\">" + emoji + "</div>"
                + "<h1>" + headline + "</h1>"
                + "<p>" + body + "</p>"
                + actionButtonHtml
                + "<div class=\"brand\">CheckFood</div>"
                + "</div></body></html>";
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