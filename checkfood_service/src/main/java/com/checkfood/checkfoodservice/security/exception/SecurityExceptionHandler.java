package com.checkfood.checkfoodservice.security.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.exception.ServiceExceptionHandler;
import com.checkfood.checkfoodservice.logging.ServiceLogger;
import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;
import com.checkfood.checkfoodservice.security.module.auth.logging.AuthLogger;
import com.checkfood.checkfoodservice.security.module.jwt.exception.JwtException;
import com.checkfood.checkfoodservice.security.module.jwt.logging.JwtLogger;
import com.checkfood.checkfoodservice.security.logging.SecurityLogger;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.http.HttpStatus;

/**
 * Exception handler pro bezpečnostní modul.
 * Rozšiřuje základní ServiceExceptionHandler o security specifické handlery.
 * Zpracovává všechny bezpečnostní výjimky a transformuje je na standardizované ErrorResponse objekty.
 *
 * @see ServiceExceptionHandler
 * @see SecurityException
 * @see SecurityLogger
 */
@RestControllerAdvice
@Component
public class SecurityExceptionHandler extends ServiceExceptionHandler {

    protected final SecurityLogger securityLogger;
    protected final AuthLogger authLogger;
    protected final JwtLogger jwtLogger;

    public SecurityExceptionHandler(
            ErrorResponseBuilder errorResponseBuilder,
            ServiceLogger serviceLogger,
            SecurityLogger securityLogger,
            AuthLogger authLogger,
            JwtLogger jwtLogger
    ) {
        super(errorResponseBuilder, serviceLogger);
        this.securityLogger = securityLogger;
        this.authLogger = authLogger;
        this.jwtLogger = jwtLogger;
    }

    /**
     * Zpracovává vlastní security výjimky obsahující error kód a HTTP status.
     *
     * @param ex security výjimka
     * @return standardizovaná chybová odpověď
     */
    @ExceptionHandler(SecurityException.class)
    public ResponseEntity<ErrorResponse> handleSecurityException(SecurityException ex) {
        securityLogger.error("Security chyba: {}", ex.getMessage());

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }

    /**
     * Zpracovává autentizační výjimky z auth modulu.
     * Používá AuthLogger pro specifické logování autentizačních chyb.
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

    /**
     * Zpracovává výjimku Spring Security při neplatných přihlašovacích údajích.
     *
     * @param ex výjimka při špatném heslu nebo emailu
     * @return chybová odpověď s HTTP 401
     */
    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<ErrorResponse> handleBadCredentials(BadCredentialsException ex) {
        securityLogger.warn("Neplatné přihlašovací údaje");

        ErrorResponse response = errorResponseBuilder.build(
                "AUTH_INVALID_CREDENTIALS",
                "Neplatný email nebo heslo.",
                HttpStatus.UNAUTHORIZED
        );

        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    /**
     * Zpracovává výjimku při nedostatečných oprávněních.
     *
     * @param ex výjimka odepření přístupu
     * @return chybová odpověď s HTTP 403
     */
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> handleAccessDenied(AccessDeniedException ex) {
        securityLogger.warn("Přístup odepřen: {}", ex.getMessage());

        ErrorResponse response = errorResponseBuilder.build(
                "ACCESS_DENIED",
                "Přístup odepřen: Nemáte dostatečná oprávnění.",
                HttpStatus.FORBIDDEN
        );

        return new ResponseEntity<>(response, HttpStatus.FORBIDDEN);
    }

    /**
     * Zpracovává validační chyby z @Valid anotace na controller metodách.
     * Extrahuje první validační chybu a vrací ji klientovi.
     *
     * @param ex výjimka validace argumentů
     * @return chybová odpověď s HTTP 400
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex) {
        String message = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .findFirst()
                .map(err -> err.getField() + ": " + err.getDefaultMessage())
                .orElse("Validation error");

        securityLogger.warn("Validační chyba: {}", message);

        ErrorResponse response = errorResponseBuilder.build(
                "VALIDATION_ERROR",
                message,
                HttpStatus.BAD_REQUEST
        );

        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }
}