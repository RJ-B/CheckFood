package com.checkfood.checkfoodservice.event.audit;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Událost vyvolaná auditním subsystémem.
 *
 * Používá se pro řetězení auditních reakcí
 * (např. fallback, monitoring).
 */
public class AuditEvent extends DomainEvent {

    private final boolean success;

    public AuditEvent(boolean success) {
        this.success = success;
    }

    public boolean isSuccess() {
        return success;
    }
}
