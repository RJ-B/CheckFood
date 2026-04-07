package com.checkfood.checkfoodservice.module.reservation.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

/**
 * Výčet chybových kódů modulu rezervací kategorizovaných do skupin:
 * {@code BUSINESS} (obchodní pravidla), {@code VALIDATION} (validace vstupu),
 * {@code SECURITY} (přístupová práva) a {@code SYSTEM} (systémové chyby).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@RequiredArgsConstructor
public enum ReservationErrorCode {
    RESERVATION_NOT_FOUND("BUSINESS"),
    SLOT_CONFLICT("BUSINESS"),
    INVALID_RESERVATION_TIME("VALIDATION"),
    RESTAURANT_CLOSED("VALIDATION"),
    TABLE_NOT_IN_RESTAURANT("VALIDATION"),
    RESERVATION_CANNOT_EDIT("BUSINESS"),
    RESERVATION_CANNOT_CANCEL("BUSINESS"),
    RESERVATION_ALREADY_CANCELLED("BUSINESS"),
    RESERVATION_ACCESS_DENIED("SECURITY"),
    PARTY_SIZE_EXCEEDS_CAPACITY("VALIDATION"),
    INVALID_STATUS_TRANSITION("BUSINESS"),
    NOT_RESTAURANT_STAFF("SECURITY"),
    CHECKIN_OUTSIDE_WINDOW("BUSINESS"),
    PENDING_CHANGE_EXISTS("BUSINESS"),
    CHANGE_REQUEST_NOT_FOUND("BUSINESS"),
    RESERVATION_LIMIT("BUSINESS"),
    RESERVATION_SYSTEM_ERROR("SYSTEM"),
    RECURRING_RESERVATION_NOT_FOUND("BUSINESS"),
    RECURRING_RESERVATION_ALREADY_ACTIVE("BUSINESS"),
    RECURRING_NO_INSTANCES_GENERATED("BUSINESS");

    private final String category;
}
