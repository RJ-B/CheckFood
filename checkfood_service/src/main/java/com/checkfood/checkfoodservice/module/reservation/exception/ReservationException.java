package com.checkfood.checkfoodservice.module.reservation.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

public class ReservationException extends AppException {

    public ReservationException(ReservationErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    public static ReservationException notFound(UUID id) {
        return new ReservationException(
                ReservationErrorCode.RESERVATION_NOT_FOUND,
                "Rezervace s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    public static ReservationException slotConflict() {
        return new ReservationException(
                ReservationErrorCode.SLOT_CONFLICT,
                "Vybraný termín již není volný. Vyberte prosím jiný čas.",
                HttpStatus.CONFLICT
        );
    }

    public static ReservationException invalidTime(String reason) {
        return new ReservationException(
                ReservationErrorCode.INVALID_RESERVATION_TIME,
                reason,
                HttpStatus.BAD_REQUEST
        );
    }

    public static ReservationException restaurantClosed() {
        return new ReservationException(
                ReservationErrorCode.RESTAURANT_CLOSED,
                "Restaurace je v tento den zavřená.",
                HttpStatus.BAD_REQUEST
        );
    }

    public static ReservationException tableNotInRestaurant() {
        return new ReservationException(
                ReservationErrorCode.TABLE_NOT_IN_RESTAURANT,
                "Stůl nepatří do této restaurace.",
                HttpStatus.BAD_REQUEST
        );
    }

    public static ReservationException cannotEdit() {
        return new ReservationException(
                ReservationErrorCode.RESERVATION_CANNOT_EDIT,
                "Rezervaci již nelze upravit (méně než 2 hodiny do začátku).",
                HttpStatus.CONFLICT
        );
    }

    public static ReservationException cannotCancel() {
        return new ReservationException(
                ReservationErrorCode.RESERVATION_CANNOT_CANCEL,
                "Rezervaci již nelze zrušit (čas rezervace již nastal).",
                HttpStatus.CONFLICT
        );
    }

    public static ReservationException alreadyCancelled() {
        return new ReservationException(
                ReservationErrorCode.RESERVATION_ALREADY_CANCELLED,
                "Rezervace je již zrušena.",
                HttpStatus.CONFLICT
        );
    }

    public static ReservationException accessDenied() {
        return new ReservationException(
                ReservationErrorCode.RESERVATION_ACCESS_DENIED,
                "Nemáte oprávnění k této rezervaci.",
                HttpStatus.FORBIDDEN
        );
    }

    public static ReservationException partySizeExceedsCapacity(int requested, int capacity) {
        return new ReservationException(
                ReservationErrorCode.PARTY_SIZE_EXCEEDS_CAPACITY,
                "Počet hostů (" + requested + ") překračuje kapacitu stolu (" + capacity + ").",
                HttpStatus.BAD_REQUEST
        );
    }

    public static ReservationException invalidStatusTransition(String from, String to) {
        return new ReservationException(
                ReservationErrorCode.INVALID_STATUS_TRANSITION,
                "Nelze změnit stav z " + from + " na " + to + ".",
                HttpStatus.CONFLICT
        );
    }

    public static ReservationException notRestaurantStaff() {
        return new ReservationException(
                ReservationErrorCode.NOT_RESTAURANT_STAFF,
                "Nejste personál této restaurace.",
                HttpStatus.FORBIDDEN
        );
    }
}
