package com.checkfood.checkfoodservice.module.reservation.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.UUID;

/**
 * Specializovaný logger pro doménové události modulu rezervací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
public class ReservationLogger {

    /**
     * Zaloguje vytvoření nové rezervace.
     *
     * @param reservationId UUID nové rezervace
     * @param restaurantId  UUID restaurace
     * @param tableId       UUID stolu
     * @param date          datum rezervace
     */
    public void logReservationCreated(UUID reservationId, UUID restaurantId, UUID tableId, LocalDate date) {
        log.info("Reservation created: id={}, restaurant={}, table={}, date={}",
                reservationId, restaurantId, tableId, date);
    }

    /**
     * Zaloguje detekci kolize časového slotu.
     *
     * @param tableId UUID stolu
     * @param date    datum kolize
     */
    public void logSlotConflict(UUID tableId, LocalDate date) {
        log.info("Slot conflict detected: table={}, date={}", tableId, date);
    }

    /**
     * Zaloguje úpravu rezervace zákazníkem.
     *
     * @param reservationId UUID rezervace
     * @param tableId       UUID nového stolu
     * @param date          nové datum rezervace
     */
    public void logReservationUpdated(UUID reservationId, UUID tableId, LocalDate date) {
        log.info("Reservation updated: id={}, table={}, date={}", reservationId, tableId, date);
    }

    /**
     * Zaloguje zrušení rezervace.
     *
     * @param reservationId UUID rezervace
     * @param date          datum rezervace
     */
    public void logReservationCancelled(UUID reservationId, LocalDate date) {
        log.info("Reservation cancelled: id={}, date={}", reservationId, date);
    }

    /**
     * Zaloguje potvrzení rezervace personálem.
     *
     * @param reservationId UUID rezervace
     * @param date          datum rezervace
     */
    public void logReservationConfirmed(UUID reservationId, LocalDate date) {
        log.info("Reservation confirmed: id={}, date={}", reservationId, date);
    }

    /**
     * Zaloguje zamítnutí rezervace personálem.
     *
     * @param reservationId UUID rezervace
     * @param date          datum rezervace
     */
    public void logReservationRejected(UUID reservationId, LocalDate date) {
        log.info("Reservation rejected: id={}, date={}", reservationId, date);
    }

    /**
     * Zaloguje check-in hosta personálem.
     *
     * @param reservationId UUID rezervace
     * @param date          datum rezervace
     */
    public void logReservationCheckedIn(UUID reservationId, LocalDate date) {
        log.info("Reservation checked-in: id={}, date={}", reservationId, date);
    }

    /**
     * Zaloguje dokončení rezervace personálem.
     *
     * @param reservationId UUID rezervace
     * @param date          datum rezervace
     */
    public void logReservationCompleted(UUID reservationId, LocalDate date) {
        log.info("Reservation completed: id={}, date={}", reservationId, date);
    }
}
