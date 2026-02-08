package com.checkfood.checkfoodservice.security.module.jwt.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.logging.ServiceLogger;
import com.checkfood.checkfoodservice.security.module.auth.logging.AuthLogger;
import com.checkfood.checkfoodservice.security.exception.SecurityExceptionHandler;
import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Exception handler pro JWT modul.
 * Rozšiřuje SecurityExceptionHandler o JWT specifické handlery.
 * Zpracovává všechny JWT výjimky a používá JwtLogger pro specifické logování.
 *
 * @see SecurityExceptionHandler
 * @see JwtException
 * @see JwtLogger
 */
@RestControllerAdvice
@Component
public class JwtExceptionHandler extends SecurityExceptionHandler {

    private final JwtLogger jwtLogger;

    public JwtExceptionHandler(
            ErrorResponseBuilder errorResponseBuilder,
            ServiceLogger serviceLogger,
            SecurityLogger securityLogger,
            AuthLogger authLogger,
            JwtLogger jwtLogger
    ) {
        // Přidán chybějící pátý parametr 'jwtLogger' do volání super()
        super(errorResponseBuilder, serviceLogger, securityLogger, authLogger, jwtLogger);
        this.jwtLogger = jwtLogger;
    }

    /**
     * Zpracovává JWT výjimky z JWT modulu.
     * Používá JwtLogger pro specifické logování JWT chyb.
     *
     * @param ex JWT výjimka
     * @return standardizovaná chybová odpověď
     */
    @ExceptionHandler(JwtException.class)
    public ResponseEntity<ErrorResponse> handleJwtException(JwtException ex) {
        jwtLogger.logAuthenticationError(ex.getMessage());

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }
}