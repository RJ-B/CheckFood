package com.checkfood.checkfoodservice.module.reservation.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.UUID;

@Slf4j
@Component
public class ReservationLogger {

    public void logReservationCreated(UUID reservationId, UUID restaurantId, UUID tableId, LocalDate date) {
        log.info("Reservation created: id={}, restaurant={}, table={}, date={}",
                reservationId, restaurantId, tableId, date);
    }

    public void logSlotConflict(UUID tableId, LocalDate date) {
        log.info("Slot conflict detected: table={}, date={}", tableId, date);
    }

    public void logReservationUpdated(UUID reservationId, UUID tableId, LocalDate date) {
        log.info("Reservation updated: id={}, table={}, date={}", reservationId, tableId, date);
    }

    public void logReservationCancelled(UUID reservationId, LocalDate date) {
        log.info("Reservation cancelled: id={}, date={}", reservationId, date);
    }

    public void logReservationConfirmed(UUID reservationId, LocalDate date) {
        log.info("Reservation confirmed: id={}, date={}", reservationId, date);
    }

    public void logReservationRejected(UUID reservationId, LocalDate date) {
        log.info("Reservation rejected: id={}, date={}", reservationId, date);
    }

    public void logReservationCheckedIn(UUID reservationId, LocalDate date) {
        log.info("Reservation checked-in: id={}, date={}", reservationId, date);
    }

    public void logReservationCompleted(UUID reservationId, LocalDate date) {
        log.info("Reservation completed: id={}, date={}", reservationId, date);
    }
}
