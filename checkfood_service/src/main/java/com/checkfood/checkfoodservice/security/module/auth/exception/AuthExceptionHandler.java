package com.checkfood.checkfoodservice.security.module.auth.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.logging.ServiceLogger;
import com.checkfood.checkfoodservice.security.module.auth.logging.AuthLogger;
import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger; // Import chybějícího loggeru
import com.checkfood.checkfoodservice.security.exception.SecurityExceptionHandler;
import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Exception handler pro autentizační modul.
 * Rozšiřuje SecurityExceptionHandler o auth specifické handlery.
 */
@RestControllerAdvice
@Component
public class AuthExceptionHandler extends SecurityExceptionHandler {

    private final AuthLogger authLogger;

    public AuthExceptionHandler(
            ErrorResponseBuilder errorResponseBuilder,
            ServiceLogger serviceLogger,
            SecurityLogger securityLogger,
            AuthLogger authLogger,
            JwtLogger jwtLogger // Přidán JwtLogger do parametrů
    ) {
        // Předání všech pěti parametrů do mateřské třídy
        super(errorResponseBuilder, serviceLogger, securityLogger, authLogger, jwtLogger);
        this.authLogger = authLogger;
    }

    /**
     * Zpracovává autentizační výjimky z auth modulu.
     *
     * @param ex autentizační výjimka
     * @return standardizovaná chybová odpověď
     */
    @ExceptionHandler(AuthException.class)
    public ResponseEntity<ErrorResponse> handleAuthException(AuthException ex) {
        authLogger.logAuthenticationError(ex.getMessage());

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }
}