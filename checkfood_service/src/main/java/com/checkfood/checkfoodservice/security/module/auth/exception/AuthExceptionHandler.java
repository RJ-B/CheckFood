package com.checkfood.checkfoodservice.security.module.auth.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.security.exception.SecurityExceptionHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

/**
 * Exception handler pro autentizační modul implementující JDK 21 pattern matching
 * pro category-based logging strategies.
 *
 * Specializuje SecurityExceptionHandler pro AuthException instances s context-aware
 * logging podle AuthErrorCode kategorií. Využívá protected utility methods
 * z parent třídy pro request metadata extraction.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see SecurityExceptionHandler
 * @see AuthException
 */
@RestControllerAdvice
@Component
@Slf4j
public class AuthExceptionHandler extends SecurityExceptionHandler {

    public AuthExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Handles AuthException instances s comprehensive logging a error response building.
     *
     * @param ex AuthException s typed error code a user message
     * @param request WebRequest pro context extraction
     * @return ResponseEntity s structured error response
     */
    @ExceptionHandler(AuthException.class)
    public ResponseEntity<ErrorResponse> handleAuthException(AuthException ex, WebRequest request) {
        logAuthExceptionContext(ex, request);

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }

    /**
     * Zaloguje kontext auth výjimky podle kategorie error kódu.
     * Kritické bezpečnostní incidenty loguje jako ERROR, upozornění jako WARN, ostatní jako INFO.
     *
     * @param ex      AuthException s typovaným error kódem
     * @param request WebRequest pro extrakci URI, IP a User-Agent
     */
    private void logAuthExceptionContext(AuthException ex, WebRequest request) {
        String uri = extractRequestUri(request);
        String ip = getRemoteAddress(request);
        String ua = request.getHeader("User-Agent");

        if (!(ex.getErrorCode() instanceof AuthErrorCode errorCode)) {
            log.error("Unknown error code type: {} - URI: {}", ex.getErrorCode(), uri);
            return;
        }

        switch (errorCode) {
            case AUTH_TOO_MANY_ATTEMPTS ->
                    log.error("BRUTE FORCE DETECTED: Too many attempts - IP: {}, UA: {}, URI: {}", ip, ua, uri);

            case AUTH_DEVICE_MISMATCH ->
                    log.error("SECURITY ALERT: Device Mismatch - IP: {}, URI: {}", ip, uri);

            case AUTH_SYSTEM_ERROR ->
                    log.error("System Auth Error - URI: {}, IP: {}, Error: {}", uri, ip, ex.getMessage(), ex);

            case AUTH_ROLE_NOT_FOUND, AUTH_REGISTRATION_FAILED ->
                    log.error("System/Logic Error: {} - URI: {}, Msg: {}", errorCode, uri, ex.getMessage());

            case AUTH_INVALID_CREDENTIALS ->
                    log.warn("Invalid credentials - IP: {}, UA: {}, URI: {}", ip, ua, uri);

            case AUTH_ACCOUNT_DISABLED ->
                    log.warn("Login attempt for DISABLED account - IP: {}, URI: {}", ip, uri);

            case AUTH_ACCOUNT_LOCKED ->
                    log.warn("Login attempt for LOCKED account - IP: {}, URI: {}", ip, uri);

            case AUTH_INVALID_TOKEN ->
                    log.warn("Invalid/Fake Token detected - IP: {}, URI: {}", ip, uri);

            case AUTH_INSUFFICIENT_PRIVILEGES ->
                    log.warn("Privilege Escalation Attempt - IP: {}, UA: {}, URI: {}", ip, ua, uri);

            case AUTH_EMAIL_EXISTS ->
                    log.info("Registration failed: Email already exists - URI: {}", uri);

            case AUTH_ACCOUNT_NOT_VERIFIED ->
                    log.info("Login attempt for unverified account - URI: {}", uri);

            case AUTH_ACCOUNT_ALREADY_ACTIVATED ->
                    log.info("Activation attempt for already active account - URI: {}", uri);

            case AUTH_PASSWORD_EXPIRED, AUTH_ACCOUNT_EXPIRED, AUTH_SESSION_EXPIRED, AUTH_TOKEN_EXPIRED ->
                    log.info("State error: {} - URI: {}", errorCode, uri);

            case AUTH_VALIDATION_ERROR ->
                    log.info("Validation error - URI: {}, Msg: {}", uri, ex.getMessage());

            default ->
                    log.error("Unexpected Auth Error - Code: {}, URI: {}, Error: {}", errorCode, uri, ex.getMessage());
        }
    }
}