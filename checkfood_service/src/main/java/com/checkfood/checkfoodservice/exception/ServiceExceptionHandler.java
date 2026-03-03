package com.checkfood.checkfoodservice.exception;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.resource.NoResourceFoundException;

/**
 * Základní exception handler pro celou aplikaci.
 * Poskytuje společné metody pro zpracování výjimek a vytváření error responses.
 * Slouží jako rodičovská třída pro specifické exception handlery jednotlivých vrstev.
 *
 * @see ErrorResponseBuilder
 * @see ServiceException
 */
@RequiredArgsConstructor
public abstract class ServiceExceptionHandler {

    protected final ErrorResponseBuilder errorResponseBuilder;

    /**
     * Zpracuje jakoukoli aplikační výjimku děděnou ze ServiceException.
     * Tento handler slouží jako fallback pro všechny vrstvy aplikace.
     *
     * @param ex service výjimka
     * @return chybová odpověď s příslušným HTTP statusem
     */
    @ExceptionHandler(ServiceException.class)
    public ResponseEntity<ErrorResponse> handleServiceException(ServiceException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );
        return new ResponseEntity<>(response, ex.getStatus());
    }

    /**
     * Zpracuje obecnou neošetřenou výjimku.
     * Vrací obecnou chybovou zprávu klientovi.
     *
     * @param ex výjimka
     * @return chybová odpověď s HTTP 500
     */
    @ExceptionHandler(NoResourceFoundException.class)
    public ResponseEntity<ErrorResponse> handleNoResourceFound(NoResourceFoundException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.NOT_FOUND,
                "Endpoint nenalezen: " + ex.getResourcePath(),
                HttpStatus.NOT_FOUND
        );
        return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGenericException(Exception ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.INTERNAL_SERVER_ERROR,
                "Došlo k interní chybě serveru. Zkuste to prosím později.",
                HttpStatus.INTERNAL_SERVER_ERROR
        );
        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ErrorResponse> handleHttpMessageNotReadable(HttpMessageNotReadableException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                "Neplatný formát požadavku.",
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleIllegalArgumentException(IllegalArgumentException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                ex.getMessage(),
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Pomocná metoda pro vytvoření ResponseEntity z ErrorResponse.
     *
     * @param errorResponse chybová odpověď
     * @param status HTTP status
     * @return ResponseEntity s error response
     */
    protected ResponseEntity<ErrorResponse> buildResponseEntity(ErrorResponse errorResponse, HttpStatus status) {
        return new ResponseEntity<>(errorResponse, status);
    }
}