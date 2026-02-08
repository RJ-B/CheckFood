package com.checkfood.checkfoodservice.event.base;

import java.time.Instant;

/**
 * Základní kontrakt pro všechny doménové události.
 *
 * Event reprezentuje fakt, že se něco stalo.
 * Neobsahuje žádnou logiku.
 */
public abstract class DomainEvent {

    private final Instant occurredAt = Instant.now();

    public Instant getOccurredAt() {
        return occurredAt;
    }

    // TODO:
    // - případně correlationId / traceId (napojení na monitoring/logging)
}
