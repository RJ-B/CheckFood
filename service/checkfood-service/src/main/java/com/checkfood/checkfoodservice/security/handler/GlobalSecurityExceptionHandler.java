package com.checkfood.checkfoodservice.security.handler;

import com.checkfood.checkfoodservice.security.auth.exception.*;
import com.checkfood.checkfoodservice.security.mfa.exception.*;
import com.checkfood.checkfoodservice.security.oauth.exception.*;
import com.checkfood.checkfoodservice.security.refresh.exception.InvalidRefreshTokenException;
import com.checkfood.checkfoodservice.security.ratelimit.exception.RateLimitExceededException;
import com.checkfood.checkfoodservice.security.user.exception.RoleNotFoundException;
import com.checkfood.checkfoodservice.security.user.exception.UserAccessException;
import com.checkfood.checkfoodservice.security.user.exception.UserNotFoundException;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

/**
 * Globální handler pro security a aplikační výjimky.
 * Zajišťuje, že frontend vždy dostane srozumitelný JSON s chybou a správný HTTP kód.
 */
@Slf4j
@RestControllerAdvice
public class GlobalSecurityExceptionHandler {

    // =====================================================
    // AUTHENTICATION (Login, Register, Tokens)
    // =====================================================

    /**
     * Zpracovává naši vlastní AuthException (obsahuje ErrorCode a HttpStatus).
     */
    @ExceptionHandler(AuthException.class)
    public ResponseEntity<ErrorResponse> handleAuthException(AuthException ex) {
        return buildResponse(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );
    }

    /**
     * Výjimka ze Spring Security při špatném heslu/emailu.
     */
    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<ErrorResponse> handleBadCredentials(BadCredentialsException ex) {
        return buildResponse(
                ErrorCode.AUTH_INVALID_CREDENTIALS,
                "Neplatný email nebo heslo.",
                HttpStatus.UNAUTHORIZED
        );
    }

    // =====================================================
    // ACCESS CONTROL
    // =====================================================

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> handleAccessDenied(AccessDeniedException ex) {
        return buildResponse(
                ErrorCode.AUTH_ACCOUNT_DISABLED, // Nebo vytvořit ErrorCode.ACCESS_DENIED
                "Přístup odepřen: Nemáte dostatečná oprávnění.",
                HttpStatus.FORBIDDEN
        );
    }

    @ExceptionHandler(UserAccessException.class)
    public ResponseEntity<ErrorResponse> handleUserAccess(UserAccessException ex) {
        return buildResponse(
                ErrorCode.AUTH_ACCOUNT_DISABLED, // Použijeme existující kód nebo generic
                ex.getMessage(),
                HttpStatus.FORBIDDEN
        );
    }

    // =====================================================
    // JWT & REFRESH TOKEN
    // =====================================================

    @ExceptionHandler(org.springframework.security.oauth2.jwt.JwtException.class)
    public ResponseEntity<ErrorResponse> handleJwt(Exception ex) {
        return buildResponse(
                ErrorCode.JWT_INVALID,
                "Neplatný nebo expirovaný token.",
                HttpStatus.UNAUTHORIZED
        );
    }

    @ExceptionHandler(InvalidRefreshTokenException.class)
    public ResponseEntity<ErrorResponse> handleRefresh(InvalidRefreshTokenException ex) {
        return buildResponse(
                ErrorCode.REFRESH_INVALID,
                ex.getMessage(),
                HttpStatus.UNAUTHORIZED
        );
    }

    // =====================================================
    // USER & ROLE (Domain Exceptions)
    // =====================================================

    @ExceptionHandler(UserNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleUserNotFound(UserNotFoundException ex) {
        return buildResponse(
                ErrorCode.VALIDATION_ERROR,
                ex.getMessage(),
                HttpStatus.NOT_FOUND
        );
    }

    @ExceptionHandler(RoleNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleRoleNotFound(RoleNotFoundException ex) {
        // Logujeme jako error, protože chybějící role je často chyba konfigurace DB
        log.error("Role not found error: {}", ex.getMessage());
        return buildResponse(
                ErrorCode.INTERNAL_ERROR,
                "Požadovaná role nebyla nalezena.",
                HttpStatus.INTERNAL_SERVER_ERROR // Nebo NOT_FOUND, dle preference
        );
    }

    // =====================================================
    // MFA (Multi-Factor Authentication)
    // =====================================================

    @ExceptionHandler(MfaNotEnabledException.class)
    public ResponseEntity<ErrorResponse> handleMfaNotEnabled(MfaNotEnabledException ex) {
        return buildResponse(
                ErrorCode.MFA_NOT_ENABLED,
                ex.getMessage(),
                HttpStatus.BAD_REQUEST
        );
    }

    @ExceptionHandler(MfaAlreadyEnabledException.class)
    public ResponseEntity<ErrorResponse> handleMfaAlreadyEnabled(MfaAlreadyEnabledException ex) {
        return buildResponse(
                ErrorCode.MFA_ALREADY_ENABLED,
                ex.getMessage(),
                HttpStatus.BAD_REQUEST
        );
    }

    @ExceptionHandler(MfaInvalidCodeException.class)
    public ResponseEntity<ErrorResponse> handleMfaInvalidCode(MfaInvalidCodeException ex) {
        return buildResponse(
                ErrorCode.MFA_INVALID_CODE,
                ex.getMessage(),
                HttpStatus.UNAUTHORIZED
        );
    }

    @ExceptionHandler(MfaRateLimitedException.class)
    public ResponseEntity<ErrorResponse> handleMfaRateLimit(MfaRateLimitedException ex) {
        return buildResponse(
                ErrorCode.MFA_RATE_LIMITED,
                ex.getMessage(),
                HttpStatus.TOO_MANY_REQUESTS
        );
    }

    // =====================================================
    // RATE LIMITING (General)
    // =====================================================

    @ExceptionHandler(RateLimitExceededException.class)
    public ResponseEntity<ErrorResponse> handleRateLimitExceeded(RateLimitExceededException ex) {
        return buildResponse(
                ErrorCode.MFA_RATE_LIMITED, // Recyklujeme kód nebo vytvoř ErrorCode.RATE_LIMIT_EXCEEDED
                ex.getMessage(),
                HttpStatus.TOO_MANY_REQUESTS
        );
    }

    // =====================================================
    // OAUTH
    // =====================================================

    @ExceptionHandler(OAuthTokenInvalidException.class)
    public ResponseEntity<ErrorResponse> handleOAuthInvalid(OAuthTokenInvalidException ex) {
        return buildResponse(
                ErrorCode.OAUTH_INVALID_TOKEN,
                ex.getMessage(),
                HttpStatus.UNAUTHORIZED
        );
    }

    @ExceptionHandler(OAuthEmailMissingException.class)
    public ResponseEntity<ErrorResponse> handleOAuthEmailMissing(OAuthEmailMissingException ex) {
        return buildResponse(
                ErrorCode.OAUTH_EMAIL_MISSING,
                ex.getMessage(),
                HttpStatus.BAD_REQUEST
        );
    }

    @ExceptionHandler(OAuthProviderNotSupportedException.class)
    public ResponseEntity<ErrorResponse> handleOAuthProvider(OAuthProviderNotSupportedException ex) {
        return buildResponse(
                ErrorCode.OAUTH_PROVIDER_NOT_SUPPORTED,
                ex.getMessage(),
                HttpStatus.BAD_REQUEST
        );
    }

    // =====================================================
    // VALIDATION & COMMON ERRORS
    // =====================================================

    /**
     * Zpracovává chyby z @Valid anotace (např. @Email, @NotBlank).
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex) {
        String message = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .findFirst()
                .map(err -> err.getField() + ": " + err.getDefaultMessage())
                .orElse("Validation error");

        return buildResponse(
                ErrorCode.VALIDATION_ERROR,
                message,
                HttpStatus.BAD_REQUEST
        );
    }

    /**
     * DŮLEŽITÉ: Zpracovává běžné argument chyby (např. "Email already registered").
     * Zajišťuje, že frontend dostane 400 Bad Request namísto 500 Internal Error.
     */
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleIllegalArgument(IllegalArgumentException ex) {
        log.warn("Validation error (IllegalArgument): {}", ex.getMessage());
        return buildResponse(
                ErrorCode.VALIDATION_ERROR,
                ex.getMessage(),
                HttpStatus.BAD_REQUEST
        );
    }

    // =====================================================
    // FALLBACK (INTERNAL ERROR)
    // =====================================================

    /**
     * Záchranná síť pro všechny ostatní neošetřené výjimky.
     * Vrací 500 a loguje stack trace.
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleAll(Exception ex) {
        log.error("Unexpected error occurred: ", ex);
        return buildResponse(
                ErrorCode.INTERNAL_ERROR,
                "Došlo k interní chybě serveru. Zkuste to prosím později.",
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    // =====================================================
    // HELPER METHOD
    // =====================================================

    private ResponseEntity<ErrorResponse> buildResponse(ErrorCode code, String message, HttpStatus status) {
        ErrorResponse response = new ErrorResponse(
                code,
                message,
                status.value(),
                LocalDateTime.now()
        );
        return new ResponseEntity<>(response, status);
    }
}