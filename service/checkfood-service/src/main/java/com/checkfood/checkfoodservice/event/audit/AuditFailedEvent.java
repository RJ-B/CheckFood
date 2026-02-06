package com.checkfood.checkfoodservice.event.audit;

/**
 * Událost signalizující selhání auditu.
 */
public class AuditFailedEvent extends AuditEvent {

    private final String reason;

    public AuditFailedEvent(String reason) {
        super(false);
        this.reason = reason;
    }

    public String getReason() {
        return reason;
    }
}
