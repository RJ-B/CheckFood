package com.checkfood.checkfoodservice.security.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.exception.ServiceExceptionHandler;
import com.checkfood.checkfoodservice.security.ratelimit.exception.RateLimitExceededException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

/**
 * Abstraktní základ pro security exception handlery poskytující společnou funkcionalitu
 * pro zpracování bezpečnostních výjimek napříč security moduly.
 *
 * Architektonické rozhodnutí: Není anotována @RestControllerAdvice pro prevenci
 * duplicitní registrace handlerů. Potomci musí být explicitně označeni jako
 * @RestControllerAdvice pro aktivaci exception handling.
 *
 * Hierarchie exception handling:
 * 1. Specifické moduly (AuthExceptionHandler, JwtExceptionHandler)
 * 2. Tento abstraktní handler (společné security exceptions)
 * 3. ServiceExceptionHandler (aplikační base handler)
 * 4. Spring default handlers
 *
 * Poskytuje standardizované zpracování Spring Security exceptions a utility
 * metody pro extrakci request metadata pro bezpečnostní auditování.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see ServiceExceptionHandler
 * @see AuthenticationException
 */
@Slf4j
public abstract class SecurityExceptionHandler extends ServiceExceptionHandler {

    /**
     * ErrorResponseBuilder pro konzistentní formátování error responses.
     * Injektovaný přes constructor z parent třídy pro dependency consistency.
     */
    public SecurityExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Fallback handler pro obecné security výjimky bez specifického handleru.
     *
     * @param ex custom SecurityException s business error details
     * @param request WebRequest pro extrakci kontextových informací
     * @return ResponseEntity s strukturovanou error response
     */
    @ExceptionHandler(SecurityException.class)
    public ResponseEntity<ErrorResponse> handleSecurityException(SecurityException ex, WebRequest request) {
        String uri = extractRequestUri(request);
        log.error("Security Exception na URI {}: {} (Status: {})", uri, ex.getMessage(), ex.getStatus());

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );
        return new ResponseEntity<>(response, ex.getStatus());
    }

    /**
     * Zpracovává authentication failures na úrovni Spring Security AuthenticationManager.
     * Generická error message pro prevenci user enumeration.
     *
     * @param ex BadCredentialsException z Spring Security
     * @param request WebRequest context pro audit trail
     * @return ResponseEntity s authentication error response
     */
    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<ErrorResponse> handleBadCredentials(BadCredentialsException ex, WebRequest request) {
        ErrorResponse response = errorResponseBuilder.build(
                "AUTH_INVALID_CREDENTIALS",
                "Neplatné přihlašovací údaje.",
                HttpStatus.UNAUTHORIZED
        );
        return new ResponseEntity<>(response, HttpStatus.UNAUTHORIZED);
    }

    /**
     * Zpracovává authorization failures z Spring Security access control.
     * Rozlišuje mezi authentication (401) a authorization (403) failures.
     *
     * @param ex AccessDeniedException z Spring Security authorization
     * @param request WebRequest context pro security audit
     * @return ResponseEntity s authorization error response
     */
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> handleAccessDenied(AccessDeniedException ex, WebRequest request) {
        ErrorResponse response = errorResponseBuilder.build(
                "ACCESS_DENIED",
                "Nemáte dostatečná oprávnění pro tuto operaci.",
                HttpStatus.FORBIDDEN
        );
        return new ResponseEntity<>(response, HttpStatus.FORBIDDEN);
    }

    /**
     * Zpracovává Bean Validation errors z @Valid annotated DTO parameters.
     * Extrahuje první validation error pro user-friendly response.
     *
     * @param ex MethodArgumentNotValidException s validation details
     * @param request WebRequest context
     * @return ResponseEntity s first validation error message
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex, WebRequest request) {
        String message = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .findFirst()
                .map(err -> err.getField() + ": " + err.getDefaultMessage())
                .orElse("Chyba validity dat.");

        ErrorResponse response = errorResponseBuilder.build(
                "VALIDATION_ERROR",
                message,
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Zpracovává překročení rate limitu. Vrací HTTP 429 Too Many Requests
     * místo výchozího HTTP 500.
     *
     * @param ex RateLimitExceededException z RateLimitAspect
     * @param request WebRequest context
     * @return ResponseEntity s rate limit error response
     */
    @ExceptionHandler(RateLimitExceededException.class)
    public ResponseEntity<ErrorResponse> handleRateLimit(RateLimitExceededException ex, WebRequest request) {
        ErrorResponse response = errorResponseBuilder.build(
                "RATE_LIMIT_EXCEEDED",
                "Příliš mnoho pokusů. Zkuste to prosím později.",
                HttpStatus.TOO_MANY_REQUESTS
        );
        return new ResponseEntity<>(response, HttpStatus.TOO_MANY_REQUESTS);
    }

    // =========================================================================
    // CHRÁNĚNÉ POMOCNÉ METODY – Sdílená infrastruktura pro potomky
    // =========================================================================

    /**
     * Extrahuje cestu URI z WebRequest pro auditní logování a sledování chyb.
     * Parsuje formát "uri=/api/auth/login" na čistou cestu URI.
     *
     * @param request WebRequest instance s metadaty požadavku
     * @return čistá cesta URI nebo "unknown" při chybě parsování
     */
    protected String extractRequestUri(WebRequest request) {
        String description = request.getDescription(false);
        return (description != null && description.startsWith("uri=")) ? description.substring(4) : "unknown";
    }

    /**
     * Extrahuje IP adresu klienta s podporou proxy hlaviček pro přesné logování.
     * Priorita: X-Forwarded-For → RemoteUser → "unknown".
     *
     * @param request WebRequest s HTTP hlavičkami
     * @return IP adresa klienta nebo "unknown"
     */
    protected String getRemoteAddress(WebRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        return request.getRemoteUser() != null ? request.getRemoteUser() : "unknown";
    }
}