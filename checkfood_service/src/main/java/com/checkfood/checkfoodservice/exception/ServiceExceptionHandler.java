package com.checkfood.checkfoodservice.exception;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.support.MissingServletRequestPartException;
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
     * Zpracuje chybu konverze typu v query/path parametru —
     * např. {@code GET /api/v1/restaurants/not-a-uuid} kde Spring nemůže
     * navázat řetězec na {@code UUID}. Bez tohoto handleru by fallback
     * {@link #handleGenericException(Exception)} vrátil 500, což je špatný
     * API contract — typing errors v inputu klienta jsou 400.
     *
     * @param ex výjimka neúspěšné konverze typu argumentu
     * @return chybová odpověď s HTTP 400
     */
    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<ErrorResponse> handleMethodArgumentTypeMismatch(
            MethodArgumentTypeMismatchException ex) {
        String message = String.format(
                "Parametr '%s' má neplatný formát.",
                ex.getName()
        );
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                message,
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Zpracuje chybějící povinný query/form parametr — např.
     * {@code GET /api/v1/restaurants/nearest?lng=13.37} bez {@code lat}.
     * Bez tohoto handleru by fallback {@link #handleGenericException(Exception)}
     * vrátil 500; chybějící povinný parametr je ale 400.
     *
     * @param ex výjimka chybějícího parametru
     * @return chybová odpověď s HTTP 400
     */
    @ExceptionHandler(MissingServletRequestParameterException.class)
    public ResponseEntity<ErrorResponse> handleMissingServletRequestParameter(
            MissingServletRequestParameterException ex) {
        String message = String.format(
                "Chybí povinný parametr '%s'.",
                ex.getParameterName()
        );
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                message,
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Zpracuje chybějící multipart část — typicky {@code POST .../logo}
     * bez {@code file} parametru. Fallback handler by ho zachytil jako 500;
     * chybějící povinný file part v multipart requestu je 400.
     *
     * @param ex výjimka chybějící části multipart requestu
     * @return chybová odpověď s HTTP 400
     */
    @ExceptionHandler(MissingServletRequestPartException.class)
    public ResponseEntity<ErrorResponse> handleMissingServletRequestPart(
            MissingServletRequestPartException ex) {
        String message = String.format(
                "Chybí povinná část '%s' v multipart požadavku.",
                ex.getRequestPartName()
        );
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                message,
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Zpracuje chybu parsingu multipart requestu — např. když klient
     * pošle {@code POST .../logo} s {@code Content-Type: application/json}
     * místo {@code multipart/form-data}, nebo s prázdným tělem.
     *
     * @param ex výjimka multipart parsingu
     * @return chybová odpověď s HTTP 400
     */
    @ExceptionHandler(MultipartException.class)
    public ResponseEntity<ErrorResponse> handleMultipartException(MultipartException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                "Neplatný multipart požadavek: " + ex.getMessage(),
                HttpStatus.BAD_REQUEST
        );
        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
    }

    /**
     * Zpracuje nepovolený HTTP method — např. {@code DELETE} na endpointu,
     * který podporuje jen {@code GET/POST}. Bez handleru by fallback
     * vrátil 500; správně je to 405 Method Not Allowed.
     *
     * @param ex výjimka nepovoleného HTTP metody
     * @return chybová odpověď s HTTP 405
     */
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public ResponseEntity<ErrorResponse> handleHttpRequestMethodNotSupported(
            HttpRequestMethodNotSupportedException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                "HTTP metoda '" + ex.getMethod() + "' není pro tento endpoint podporována.",
                HttpStatus.METHOD_NOT_ALLOWED
        );
        return new ResponseEntity<>(response, HttpStatus.METHOD_NOT_ALLOWED);
    }

    /**
     * Zpracuje nepodporovaný Content-Type — např. když klient pošle
     * {@code application/xml} na endpoint, který přijímá jen JSON. Vrátí
     * 415 Unsupported Media Type místo fallback 500.
     *
     * @param ex výjimka nepodporovaného content-type
     * @return chybová odpověď s HTTP 415
     */
    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    public ResponseEntity<ErrorResponse> handleHttpMediaTypeNotSupported(
            HttpMediaTypeNotSupportedException ex) {
        ErrorResponse response = errorResponseBuilder.build(
                ErrorCode.VALIDATION_ERROR,
                "Content-Type '" + ex.getContentType() + "' není podporován tímto endpointem.",
                HttpStatus.UNSUPPORTED_MEDIA_TYPE
        );
        return new ResponseEntity<>(response, HttpStatus.UNSUPPORTED_MEDIA_TYPE);
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