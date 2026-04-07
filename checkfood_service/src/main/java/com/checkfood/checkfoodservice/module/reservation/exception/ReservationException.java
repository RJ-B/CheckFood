package com.checkfood.checkfoodservice.module.reservation.exception;

import com.checkfood.checkfoodservice.module.exception.AppException;
import org.springframework.http.HttpStatus;

import java.util.UUID;

/**
 * Doménová výjimka pro modul rezervací.
 * Poskytuje factory metody pro všechny typové chybové stavy modulu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class ReservationException extends AppException {

    /**
     * Vytvoří novou instanci výjimky s daným kódem chyby, zprávou a HTTP statusem.
     *
     * @param errorCode kód chyby z výčtu {@link ReservationErrorCode}
     * @param message   lidsky čitelná chybová zpráva
     * @param status    HTTP status odpovědi
     */
    public ReservationException(ReservationErrorCode errorCode, String message, HttpStatus status) {
        super(errorCode, message, status);
    }

    /**
     * Rezervace s daným ID nebyla nalezena.
     *
     * @param id UUID hledané rezervace
     * @return výjimka s HTTP 404
     */
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

    public static ReservationException checkInOutsideWindow() {
        return new ReservationException(
                ReservationErrorCode.CHECKIN_OUTSIDE_WINDOW,
                "Check-in je možný pouze 30 minut před až 60 minut po začátku rezervace.",
                HttpStatus.CONFLICT
        );
    }

    public static ReservationException pendingChangeExists() {
        return new ReservationException(
                ReservationErrorCode.PENDING_CHANGE_EXISTS,
                "Pro tuto rezervaci již existuje nevyřízený návrh změny.",
                HttpStatus.CONFLICT
        );
    }

    public static ReservationException changeRequestNotFound(UUID id) {
        return new ReservationException(
                ReservationErrorCode.CHANGE_REQUEST_NOT_FOUND,
                "Návrh změny s ID " + id + " nebyl nalezen.",
                HttpStatus.NOT_FOUND
        );
    }

    public static ReservationException reservationLimitPerDay(int max) {
        return new ReservationException(
                ReservationErrorCode.RESERVATION_LIMIT,
                "Maximální počet rezervací na restauraci na den je " + max + ".",
                HttpStatus.TOO_MANY_REQUESTS
        );
    }

    public static ReservationException reservationLimitTotal(int max) {
        return new ReservationException(
                ReservationErrorCode.RESERVATION_LIMIT,
                "Maximální počet aktivních rezervací je " + max + ".",
                HttpStatus.TOO_MANY_REQUESTS
        );
    }

    public static ReservationException recurringNotFound(UUID id) {
        return new ReservationException(
                ReservationErrorCode.RECURRING_RESERVATION_NOT_FOUND,
                "Opakovaná rezervace s ID " + id + " nebyla nalezena.",
                HttpStatus.NOT_FOUND
        );
    }

    public static ReservationException recurringAlreadyActive() {
        return new ReservationException(
                ReservationErrorCode.RECURRING_RESERVATION_ALREADY_ACTIVE,
                "Opakovaná rezervace již byla potvrzena nebo odmítnuta.",
                HttpStatus.CONFLICT
        );
    }

    public static ReservationException recurringNoInstances() {
        return new ReservationException(
                ReservationErrorCode.RECURRING_NO_INSTANCES_GENERATED,
                "Nepodařilo se vygenerovat žádnou instanci rezervace — všechny termíny jsou obsazeny.",
                HttpStatus.CONFLICT
        );
    }
}
