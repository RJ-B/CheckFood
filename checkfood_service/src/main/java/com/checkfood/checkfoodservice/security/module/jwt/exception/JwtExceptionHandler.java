package com.checkfood.checkfoodservice.security.module.jwt.exception;

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
 * Exception handler pro JWT modul s category-based logging strategií.
 * Využívá zděděné utility metody ze {@code SecurityExceptionHandler} pro extrakci kontextu požadavku.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see SecurityExceptionHandler
 * @see JwtException
 */
@RestControllerAdvice
@Component
@Slf4j
public class JwtExceptionHandler extends SecurityExceptionHandler {

    public JwtExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Zpracuje JwtException a vrátí strukturovanou chybovou odpověď.
     *
     * @param ex      JWT výjimka s typed error kódem
     * @param request WebRequest pro extrakci kontextu
     * @return ResponseEntity se strukturovanou chybovou odpovědí
     */
    @ExceptionHandler(JwtException.class)
    public ResponseEntity<ErrorResponse> handleJwtException(JwtException ex, WebRequest request) {
        logJwtExceptionContext(ex, request);

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }

    /**
     * Zpracuje Spring Security JwtException a obalí ji do standardní JwtException.
     *
     * @param ex      Spring Security JWT výjimka
     * @param request WebRequest pro extrakci kontextu
     * @return ResponseEntity se strukturovanou chybovou odpovědí
     */
    @ExceptionHandler(org.springframework.security.oauth2.jwt.JwtException.class)
    public ResponseEntity<ErrorResponse> handleSpringJwtException(
            org.springframework.security.oauth2.jwt.JwtException ex, WebRequest request) {

        JwtException wrappedEx = JwtException.invalidToken("Spring Security Reject: " + ex.getMessage());
        logJwtExceptionContext(wrappedEx, request);

        ErrorResponse response = errorResponseBuilder.build(
                wrappedEx.getErrorCode(),
                wrappedEx.getMessage(),
                wrappedEx.getStatus()
        );
        return new ResponseEntity<>(response, wrappedEx.getStatus());
    }

    private void logJwtExceptionContext(JwtException ex, WebRequest request) {
        String uri = extractRequestUri(request);
        String ip = getRemoteAddress(request);
        String tokenInfo = extractTokenInfo(request.getHeader("Authorization"));

        if (!(ex.getErrorCode() instanceof JwtErrorCode errorCode)) {
            log.error("Unknown JWT error code: {} - URI: {}", ex.getErrorCode(), uri);
            return;
        }

        switch (errorCode) {
            case JWT_INVALID_SIGNATURE ->
                    log.error("SECURITY ALERT: Invalid Signature - IP: {}, URI: {}, Token: {}", ip, uri, tokenInfo);

            case JWT_BLACKLISTED, JWT_INVALID_CLAIMS, JWT_UNSUPPORTED ->
                    log.warn("JWT Security Issue: {} - IP: {}, URI: {}, Token: {}", errorCode, ip, uri, tokenInfo);

            case JWT_EXPIRED, JWT_MISSING, JWT_INVALID, JWT_USER_NOT_FOUND, JWT_ACCOUNT_DISABLED ->
                    log.info("JWT Validation Issue: {} - URI: {}, Msg: {}", errorCode, uri, ex.getMessage());

            case JWT_GENERATION_ERROR, JWT_PARSE_ERROR ->
                    log.error("JWT System Error - URI: {}, Error: {}", uri, ex.getMessage(), ex);

            default ->
                    log.error("Unexpected JWT Error - Code: {}, URI: {}, Error: {}", errorCode, uri, ex.getMessage());
        }
    }

    /**
     * Extrahuje zkrácené informace o tokenu z Authorization headeru pro účely logování.
     *
     * @param authorization hodnota Authorization headeru
     * @return zkrácený token nebo popis jeho stavu
     */
    private String extractTokenInfo(String authorization) {
        if (authorization == null || !authorization.startsWith("Bearer ")) {
            return "none";
        }
        try {
            String token = authorization.substring(7);
            if (token.length() > 15) {
                return String.format("%s... (len:%d)", token.substring(0, 6), token.length());
            }
            return "invalid-len";
        } catch (Exception e) {
            return "parse-err";
        }
    }
}