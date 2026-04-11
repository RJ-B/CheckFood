package com.checkfood.checkfoodservice.exception;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.resource.NoResourceFoundException;

/**
 * Základní exception handler pro celou aplikaci.
 * Poskytuje společné metody pro zpracování výjimek a vytváření error responses.
 * Slouží jako rodičovská třída pro specifické exception handlery jednotlivých vrstev.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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
     * Zpracuje výjimku při nenalezení endpointu.
     *
     * @param ex výjimka neexistujícího zdroje
     * @return chybová odpověď s HTTP 404
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

    /**
     * Zpracuje ResponseStatusException — zachovává HTTP status kód definovaný v místě vyhození.
     * Musí být registrován před generickým handlerem Exception, jinak by byl přepsán kódem 500.
     *
     * @param ex výjimka s explicitně nastaveným HTTP statusem
     * @return odpověď se statusem z výjimky
     */
    @ExceptionHandler(ResponseStatusException.class)
    public ResponseEntity<ErrorResponse> handleResponseStatusException(ResponseStatusException ex) {
        HttpStatus status = HttpStatus.resolve(ex.getStatusCode().value());
        if (status == null) status = HttpStatus.INTERNAL_SERVER_ERROR;
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.INTERNAL_SERVER_ERROR,
                ex.getReason() != null ? ex.getReason() : ex.getMessage(),
                status
        );
        return new ResponseEntity<>(response, status);
    }

    /**
     * Zpracuje neošetřenou výjimku jako fallback. Vrací obecnou chybovou zprávu klientovi.
     *
     * @param ex neošetřená výjimka
     * @return chybová odpověď s HTTP 500
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGenericException(Exception ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.INTERNAL_SERVER_ERROR,
                "Došlo k interní chybě serveru. Zkuste to prosím později.",
                HttpStatus.INTERNAL_SERVER_ERROR
        );
        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * Zpracuje výjimku způsobenou nečitelným nebo neplatným tělem HTTP požadavku.
     *
     * @param ex výjimka neplatného formátu
     * @return chybová odpověď s HTTP 400
     */
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ErrorResponse> handleHttpMessageNotReadable(HttpMessageNotReadableException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                "Neplatný formát požadavku.",
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Zpracuje výjimku způsobenou neplatným argumentem.
     *
     * @param ex výjimka neplatného argumentu
     * @return chybová odpověď s HTTP 400
     */
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