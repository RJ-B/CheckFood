package com.checkfood.checkfoodservice.listener.application;

import com.checkfood.checkfoodservice.event.application.ReservationExpiredEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * Posluchač doménové události expirace rezervace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class ReservationExpiredListener {

    /**
     * Zpracuje událost expirace rezervace.
     *
     * @param event událost s daty expirované rezervace
     */
    @EventListener
    public void onReservationExpired(ReservationExpiredEvent event) {
        // TODO: audit expirace, notifikace uživatele, metriky
    }
}
