package com.checkfood.checkfoodservice.module.restaurant.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import com.checkfood.checkfoodservice.module.exception.AppExceptionHandler;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

/**
 * Globální handler výjimek modulu restaurací. Mapuje {@link RestaurantException} na HTTP odpovědi.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestControllerAdvice
@Component
@Slf4j
public class RestaurantExceptionHandler extends AppExceptionHandler {

    /**
     * Vytvoří handler s instancí builderu pro formátování chybových odpovědí.
     *
     * @param errorResponseBuilder builder pro sestavení standardizované chybové odpovědi
     */
    public RestaurantExceptionHandler(ErrorResponseBuilder errorResponseBuilder) {
        super(errorResponseBuilder);
    }

    /**
     * Zpracuje výjimku modulu restaurací a vrátí odpovídající HTTP odpověď.
     *
     * @param ex      zachycená výjimka
     * @param request aktuální HTTP požadavek
     * @return HTTP odpověď s chybovým tělem
     */
    @ExceptionHandler(RestaurantException.class)
    public ResponseEntity<ErrorResponse> handleRestaurantException(RestaurantException ex, WebRequest request) {
        logRestaurantException(ex, request);

        ErrorResponse response = errorResponseBuilder.build(
                ex.getErrorCode(),
                ex.getMessage(),
                ex.getStatus()
        );

        return new ResponseEntity<>(response, ex.getStatus());
    }

    private void logRestaurantException(RestaurantException ex, WebRequest request) {
        String uri = extractRequestUri(request);

        if (!(ex.getErrorCode() instanceof RestaurantErrorCode code)) {
            log.error("Unknown error code type in Restaurant module: {}", ex.getErrorCode());
            return;
        }

        switch (code) {
            case RESTAURANT_SYSTEM_ERROR ->
                    log.error("SYSTEM ERROR [Restaurant]: {} - URI: {}", ex.getMessage(), uri, ex);

            case RESTAURANT_ACCESS_DENIED ->
                    log.warn("SECURITY: Unauthorized access attempt to restaurant - URI: {}", uri);

            case TABLE_OCCUPIED, CAPACITY_EXCEEDED ->
                    log.info("Business Conflict: {} - URI: {}", ex.getMessage(), uri);

            case RESTAURANT_NOT_FOUND, TABLE_NOT_FOUND, EMPLOYEE_NOT_FOUND, NO_RESTAURANT_ASSIGNED ->
                    log.debug("Resource not found: {} - URI: {}", ex.getMessage(), uri);

            case EMPLOYEE_ALREADY_EXISTS ->
                    log.info("Business Conflict: {} - URI: {}", ex.getMessage(), uri);

            default ->
                    log.info("Restaurant module exception: {} - Code: {}", ex.getMessage(), code);
        }
    }
}