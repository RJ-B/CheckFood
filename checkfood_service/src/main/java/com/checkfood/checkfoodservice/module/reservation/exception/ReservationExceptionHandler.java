package com.checkfood.checkfoodservice.module.reservation.exception;

import com.checkfood.checkfoodservice.exception.ErrorResponse;
import com.checkfood.checkfoodservice.exception.ErrorResponseBuilder;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.annotation.Order;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
@Order(1)
@RequiredArgsConstructor
public class ReservationExceptionHandler {

    private final ErrorResponseBuilder errorResponseBuilder;

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
