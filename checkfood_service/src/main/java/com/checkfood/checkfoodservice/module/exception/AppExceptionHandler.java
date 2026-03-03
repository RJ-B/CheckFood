package com.checkfood.checkfoodservice.module.exception;

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
 * Abstraktní handler pro byznys moduly.
 */
@Slf4j
public abstract class AppExceptionHandler extends ServiceExceptionHandler {

    public AppExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

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

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> handleAccessDenied(AccessDeniedException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.FORBIDDEN,
                "Nemáte oprávnění k provedení této operace.",
                HttpStatus.FORBIDDEN
        );
        return new ResponseEntity<>(response, HttpStatus.FORBIDDEN);
    }

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

    protected String extractRequestUri(WebRequest request) {
        String description = request.getDescription(false);
        return (description != null && description.startsWith("uri=")) ? description.substring(4) : "unknown";
    }
}