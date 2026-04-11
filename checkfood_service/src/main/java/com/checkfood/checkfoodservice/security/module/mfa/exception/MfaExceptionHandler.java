package com.checkfood.checkfoodservice.security.module.mfa.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Global exception handler for the MFA module. Maps domain exceptions to
 * the right HTTP status codes instead of letting them fall through to the
 * generic {@code ServiceExceptionHandler.handleGenericException} which
 * would serve them as 500.
 *
 * <p>Without this handler:
 * <ul>
 *   <li>{@code MfaAlreadyEnabledException} → 500 (should be 409)</li>
 *   <li>{@code MfaNotEnabledException} → 500 (should be 409)</li>
 *   <li>{@code MfaInvalidCodeException} → 500 (should be 401)</li>
 *   <li>{@code MfaRateLimitedException} → 500 (should be 429)</li>
 *   <li>{@code MfaException} (base, e.g. wrong password) → 500 (should be 401)</li>
 * </ul>
 *
 * @author CheckFood team, Apr 2026
 */
@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE + 10)
@Slf4j
@RequiredArgsConstructor
public class MfaExceptionHandler {

    private final ErrorResponseBuilder errorResponseBuilder;

    @ExceptionHandler(MfaAlreadyEnabledException.class)
    public ResponseEntity<ErrorResponse> handleAlreadyEnabled(MfaAlreadyEnabledException ex) {
        return build("MFA_ALREADY_ENABLED", ex.getMessage(), HttpStatus.CONFLICT);
    }

    @ExceptionHandler(MfaNotEnabledException.class)
    public ResponseEntity<ErrorResponse> handleNotEnabled(MfaNotEnabledException ex) {
        return build("MFA_NOT_ENABLED", ex.getMessage(), HttpStatus.CONFLICT);
    }

    @ExceptionHandler(MfaInvalidCodeException.class)
    public ResponseEntity<ErrorResponse> handleInvalidCode(MfaInvalidCodeException ex) {
        // Generic 401 — never reveal whether the user exists or whether
        // the code was malformed vs. wrong.
        return build("MFA_INVALID_CODE", "Invalid MFA code.", HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(MfaRateLimitedException.class)
    public ResponseEntity<ErrorResponse> handleRateLimited(MfaRateLimitedException ex) {
        return build("MFA_RATE_LIMITED", ex.getMessage(), HttpStatus.TOO_MANY_REQUESTS);
    }

    /**
     * Fallback for the base {@link MfaException} — e.g. wrong password on
     * disable. Always 401 and a generic message.
     */
    @ExceptionHandler(MfaException.class)
    public ResponseEntity<ErrorResponse> handleGeneric(MfaException ex) {
        log.debug("MFA domain error: {}", ex.getMessage());
        return build("MFA_ERROR", "Invalid MFA operation.", HttpStatus.UNAUTHORIZED);
    }

    private ResponseEntity<ErrorResponse> build(String code, String message, HttpStatus status) {
        ErrorResponse response = errorResponseBuilder.build(code, message, status);
        return new ResponseEntity<>(response, status);
    }
}
