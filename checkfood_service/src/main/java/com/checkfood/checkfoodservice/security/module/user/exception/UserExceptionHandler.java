package com.checkfood.checkfoodservice.security.module.user.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.logging.ServiceLogger;
import com.checkfood.checkfoodservice.security.module.auth.logging.AuthLogger;
import com.checkfood.checkfoodservice.security.exception.SecurityExceptionHandler;
import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import com.checkfood.checkfoodservice.security.module.user.logging.UserLogger;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Exception handler pro user modul.
 * Rozšiřuje SecurityExceptionHandler o user specifické handlery.
 * Zpracovává všechny user výjimky a používá UserLogger pro specifické logování.
 *
 * @see SecurityExceptionHandler
 * @see UserException
 * @see UserLogger
 */
@RestControllerAdvice
@Component
public class UserExceptionHandler extends SecurityExceptionHandler {

    private final UserLogger userLogger;

    public UserExceptionHandler(
            ErrorResponseBuilder errorResponseBuilder,
            ServiceLogger serviceLogger,
            SecurityLogger securityLogger,
            AuthLogger authLogger,
            JwtLogger jwtLogger,
            UserLogger userLogger
    ) {
        super(errorResponseBuilder, serviceLogger, securityLogger, authLogger, jwtLogger);
        this.userLogger = userLogger;
    }

    /**
     * Zpracovává user výjimky z user modulu.
     * Používá UserLogger pro specifické logování user chyb.
     *
     * @param ex user výjimka
     * @return standardizovaná chybová odpověď
     */
    @ExceptionHandler(UserException.class)
    public ResponseEntity<ErrorResponse> handleUserException(UserException ex) {
        userLogger.logUserError(ex.getMessage());

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }
}