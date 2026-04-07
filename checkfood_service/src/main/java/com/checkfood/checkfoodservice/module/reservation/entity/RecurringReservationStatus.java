package com.checkfood.checkfoodservice.module.reservation.entity;

/**
 * Výčet stavů opakované rezervace ({@link RecurringReservation}).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum RecurringReservationStatus {
    PENDING_CONFIRMATION,
    ACTIVE,
    REJECTED,
    CANCELLED
}
