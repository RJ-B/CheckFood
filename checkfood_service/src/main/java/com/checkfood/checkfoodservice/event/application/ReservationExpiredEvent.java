package com.checkfood.checkfoodservice.event.application;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Doménová událost vyvolaná při expiraci rezervace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class ReservationExpiredEvent extends DomainEvent {

    private final Long reservationId;

    /**
     * Vytvoří událost expirace rezervace.
     *
     * @param reservationId identifikátor expirované rezervace
     */
    public ReservationExpiredEvent(Long reservationId) {
        this.reservationId = reservationId;
    }

    /**
     * Vrátí identifikátor expirované rezervace.
     *
     * @return ID rezervace
     */
    public Long getReservationId() {
        return reservationId;
    }
}
