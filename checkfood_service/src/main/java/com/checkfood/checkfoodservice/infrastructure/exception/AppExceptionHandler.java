package com.checkfood.checkfoodservice.infrastructure.exception;

import com.checkfood.checkfoodservice.exception.ErrorCode;
import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.exception.ServiceExceptionHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

/**
 * Abstraktní handler výjimek pro byznys moduly.
 * Zpracovává {@link AppException}, {@link AccessDeniedException} a validační chyby jednotným způsobem.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
public abstract class AppExceptionHandler extends ServiceExceptionHandler {

    /**
     * Vytvoří handler s potřebným builderem chybových odpovědí.
     *
     * @param errorResponseBuilder builder pro sestavení standardizované chybové odpovědi
     */
    public AppExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Zpracuje {@link AppException} a vrátí standardizovanou chybovou odpověď.
     *
     * @param ex      zachycená modulová výjimka
     * @param request aktuální HTTP požadavek
     * @return odpověď s chybovým kódem a příslušným HTTP statusem
     */
    @ExceptionHandler(AppException.class)
    public ResponseEntity<ErrorResponse> handleAppException(AppException ex, WebRequest request) {
        String uri = extractRequestUri(request);
        log.error("Module Business Error [{}]: {} - URI: {}", ex.getErrorCode(), ex.getMessage(), uri);

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }

    /**
     * Zpracuje {@link AccessDeniedException} a vrátí odpověď s HTTP 403 Forbidden.
     *
     * @param ex zachycená výjimka zamítnutí přístupu
     * @return odpověď s chybou FORBIDDEN
     */
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> handleAccessDenied(AccessDeniedException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.FORBIDDEN,
                "Nemáte oprávnění k provedení této operace.",
                HttpStatus.FORBIDDEN
        );
        return new ResponseEntity<>(response, HttpStatus.FORBIDDEN);
    }

    /**
     * Zpracuje chybu validace requestu a vrátí první nalezené chybové hlášení.
     *
     * @param ex zachycená výjimka validace
     * @return odpověď s chybou VALIDATION_ERROR a HTTP 400
     */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex) {
        String message = ex.getBindingResult().getFieldErrors().stream()
                .findFirst()
                .map(err -> err.getField() + ": " + err.getDefaultMessage())
                .orElse("Neplatný požadavek.");

        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                message,
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Extrahuje URI z WebRequest pro účely logování.
     *
     * @param request aktuální HTTP požadavek
     * @return URI požadavku nebo {@code "unknown"} pokud nelze určit
     */
    protected String extractRequestUri(WebRequest request) {
        String description = request.getDescription(false);
        return (description != null && description.startsWith("uri=")) ? description.substring(4) : "unknown";
    }
}
