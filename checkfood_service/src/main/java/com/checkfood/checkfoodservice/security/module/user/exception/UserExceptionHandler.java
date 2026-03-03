package com.checkfood.checkfoodservice.security.module.user.exception;

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
 * Exception handler pro User modul.
 * Využívá zděděné metody pro extrakci kontextu požadavku.
 */
@RestControllerAdvice
@Component
@Slf4j
public class UserExceptionHandler extends SecurityExceptionHandler {

    public UserExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    @ExceptionHandler(UserException.class)
    public ResponseEntity<ErrorResponse> handleUserException(UserException ex, WebRequest request) {
        logUserExceptionContext(ex, request);

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }

    private void logUserExceptionContext(UserException ex, WebRequest request) {
        // Volání chráněných metod z rodiče
        String uri = extractRequestUri(request);
        String ip = getRemoteAddress(request);
        String ua = request.getHeader("User-Agent");

        if (!(ex.getErrorCode() instanceof UserErrorCode errorCode)) {
            log.error("Unexpected User error code: {} - URI: {}", ex.getErrorCode(), uri);
            return;
        }

        switch (errorCode) {
            case USER_ACCESS_DENIED, USER_INSUFFICIENT_PERMISSIONS ->
                    log.warn("SECURITY ALERT: Unauthorized Access Attempt - IP: {}, URI: {}, UA: {}, Msg: {}",
                            ip, uri, ua, ex.getMessage());

            case USER_EMAIL_EXISTS ->
                    log.info("Email Conflict - IP: {}, URI: {}, Msg: {}", ip, uri, ex.getMessage());

            case USER_NOT_FOUND, ROLE_NOT_FOUND, USER_INVALID_OPERATION ->
                    log.info("User Operation Failed - URI: {}, Msg: {}", uri, ex.getMessage());

            case USER_SYSTEM_ERROR ->
                    log.error("User Module System Error - URI: {}, Error: {}", uri, ex.getMessage(), ex);

            default ->
                    log.error("Unexpected User Exception - Code: {}, URI: {}, Error: {}", errorCode, uri, ex.getMessage());
        }
    }
}