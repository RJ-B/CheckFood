package com.checkfood.checkfoodservice.listener.application;

import com.checkfood.checkfoodservice.event.application.ReservationExpiredEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Reaguje na expiraci rezervace.
 */
@Component
public class ReservationExpiredListener {

    @EventListener
    public void onReservationExpired(ReservationExpiredEvent event) {

        // TODO:
        // - audit expirace
        // - notifikace uživatele
        // - metriky
    }
}
