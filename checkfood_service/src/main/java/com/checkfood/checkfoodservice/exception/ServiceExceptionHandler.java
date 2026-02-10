package com.checkfood.checkfoodservice.exception;

import com.checkfood.checkfoodservice.logging.ServiceLogger;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;

/**
 * Základní exception handler pro celou aplikaci.
 * Poskytuje společné metody pro zpracování výjimek a vytváření error responses.
 * Slouží jako rodičovská třída pro specifické exception handlery jednotlivých vrstev.
 *
 * @see ErrorResponseBuilder
 * @see ServiceLogger
 * @see ServiceException
 */
@RequiredArgsConstructor
public abstract class ServiceExceptionHandler {

    protected final ErrorResponseBuilder errorResponseBuilder;
    protected final ServiceLogger serviceLogger;

    /**
     * Zpracuje jakoukoli aplikační výjimku děděnou ze ServiceException.
     * Tento handler slouží jako fallback pro všechny vrstvy aplikace.
     *
     * @param ex service výjimka
     * @return chybová odpověď s příslušným HTTP statusem
     */
    @ExceptionHandler(ServiceException.class)
    public ResponseEntity<ErrorResponse> handleServiceException(ServiceException ex) {
        serviceLogger.error("Aplikační chyba: {}", ex.getMessage());

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }

    /**
     * Zpracuje obecnou neošetřenou výjimku.
     * Loguje kompletní stack trace a vrací obecnou chybovou zprávu klientovi.
     *
     * @param ex výjimka
     * @return chybová odpověď s HTTP 500
     */
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGenericException(Exception ex) {
        serviceLogger.error("Neočekávaná chyba: ", ex);

        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.INTERNAL_SERVER_ERROR,
                "Došlo k interní chybě serveru. Zkuste to prosím později.",
                HttpStatus.INTERNAL_SERVER_ERROR
        );

        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * Zpracuje výjimku neplatných argumentů.
     * Zajišťuje, že validační chyby vrací HTTP 400 namísto 500.
     *
     * @param ex výjimka neplatného argumentu
     * @return chybová odpověď s HTTP 400
     */
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleIllegalArgumentException(IllegalArgumentException ex) {
        serviceLogger.warn("Validační chyba: {}", ex.getMessage());

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