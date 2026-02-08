package com.checkfood.checkfoodservice.event.application;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Událost vyvolaná při expiraci rezervace.
 */
public class ReservationExpiredEvent extends DomainEvent {

    private final Long reservationId;

    public ReservationExpiredEvent(Long reservationId) {
        this.reservationId = reservationId;
    }

    public Long getReservationId() {
        return reservationId;
    }
}
