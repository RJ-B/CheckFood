package com.checkfood.checkfoodservice.module.reservation.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.annotation.Order;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * Globální handler výjimek modulu rezervací.
 * Zpracovává {@link ReservationException} a převádí je na standardizovanou {@link ErrorResponse}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@RestControllerAdvice
@Order(1)
@RequiredArgsConstructor
public class ReservationExceptionHandler {

    private final ErrorResponseBuilder errorResponseBuilder;

    /**
     * Zpracuje výjimku rezervace a vrátí odpovídající HTTP odpověď s chybovým tělem.
     * Kolizní chyby jsou logovány na úrovni INFO, systémové chyby na ERROR, ostatní na DEBUG.
     *
     * @param ex zachycená výjimka
     * @return HTTP odpověď se standardizovaným chybovým tělem
     */
    @ExceptionHandler(ReservationException.class)
    public ResponseEntity<ErrorResponse> handleReservationException(ReservationException ex) {
        var errorCode = (ReservationErrorCode) ex.getErrorCode();

        switch (errorCode) {
            case SLOT_CONFLICT -> log.info("Reservation conflict: {}", ex.getMessage());
            case RESERVATION_SYSTEM_ERROR -> log.error("Reservation system error: {}", ex.getMessage(), ex);
            default -> log.debug("Reservation error [{}]: {}", errorCode, ex.getMessage());
        }

        var body = errorResponseBuilder.build(ex.getErrorCode(), ex.getMessage(), ex.getStatus());
        return new ResponseEntity<>(body, ex.getStatus());
    }
}
