package com.checkfood.checkfoodservice.module.reservation.entity;

/**
 * Výčet stavů rezervace v rámci jejího životního cyklu.
 * {@code RESERVED} je zachován pro zpětnou kompatibilitu s existujícími záznamy v databázi.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public enum ReservationStatus {
    PENDING_CONFIRMATION,
    CONFIRMED,
    RESERVED,
    CHECKED_IN,
    REJECTED,
    CANCELLED,
    COMPLETED
}
