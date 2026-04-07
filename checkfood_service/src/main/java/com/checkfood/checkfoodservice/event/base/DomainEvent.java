package com.checkfood.checkfoodservice.event.base;

import java.time.Instant;

/**
 * Základní kontrakt pro všechny doménové události.
 * Event reprezentuje fakt, že se něco stalo, a neobsahuje žádnou logiku.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public abstract class DomainEvent {

    private final Instant occurredAt = Instant.now();

    /**
     * Vrátí čas vzniku události.
     *
     * @return okamžik vytvoření události
     */
    public Instant getOccurredAt() {
        return occurredAt;
    }
}
