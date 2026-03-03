package com.checkfood.checkfoodservice.security.module.oauth.exception;

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
 * Exception handler pro OAuth modul.
 * * SENIOR IMPLEMENTACE (JDK 21):
 * - Využívá Switch Expressions.
 * - Odstraněny duplicitní metody (využívá implementaci z SecurityExceptionHandler).
 */
@RestControllerAdvice
@Component
@Slf4j
public class OAuthExceptionHandler extends SecurityExceptionHandler {

    public OAuthExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    @ExceptionHandler(OAuthException.class)
    public ResponseEntity<ErrorResponse> handleOAuthException(OAuthException ex, WebRequest request) {
        logOAuthExceptionContext(ex, request);

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }

    private void logOAuthExceptionContext(OAuthException ex, WebRequest request) {
        // Tyto metody jsou volány z rodičovské třídy SecurityExceptionHandler
        String uri = extractRequestUri(request);
        String ip = getRemoteAddress(request);
        String ua = request.getHeader("User-Agent");
        String provider = extractProviderFromUri(uri);

        if (!(ex.getErrorCode() instanceof OAuthErrorCode errorCode)) {
            log.error("Unexpected OAuth error code: {} - URI: {}", ex.getErrorCode(), uri);
            return;
        }

        // JDK 21 Switch Expression
        switch (errorCode) {
            case OAUTH_TOKEN_INVALID ->
                    log.warn("SECURITY: Invalid OAuth Token - Provider: {}, IP: {}, URI: {}", provider, ip, uri);

            case OAUTH_PROVIDER_MISMATCH ->
                    log.warn("Account Linking Conflict - Provider: {}, IP: {}, URI: {}, Msg: {}", provider, ip, uri, ex.getMessage());

            case OAUTH_PROVIDER_NOT_SUPPORTED ->
                    log.info("Unsupported Provider Requested - Provider: {}, IP: {}", provider, ip);

            case OAUTH_USER_DATA_MISSING ->
                    log.info("OAuth User Data Missing - Provider: {}, IP: {}", provider, ip);

            case OAUTH_PROVIDER_COMMUNICATION_ERROR ->
                    log.error("External Provider API Error - Provider: {}, IP: {}, Error: {}", provider, ip, ex.getMessage(), ex);

            case OAUTH_INTERNAL_ERROR ->
                    log.error("Internal OAuth Module Error - URI: {}, Error: {}", uri, ex.getMessage(), ex);

            default ->
                    log.error("Unexpected OAuth Exception - Code: {}, Provider: {}, Error: {}", errorCode, provider, ex.getMessage());
        }
    }

    private String extractProviderFromUri(String uri) {
        if (uri == null) return "unknown";
        String lowerUri = uri.toLowerCase();
        if (lowerUri.contains("google")) return "GOOGLE";
        if (lowerUri.contains("apple")) return "APPLE";
        if (lowerUri.contains("facebook")) return "FACEBOOK";
        return "UNKNOWN";
    }
}