package com.checkfood.checkfoodservice.event.audit;

import com.checkfood.checkfoodservice.event.base.DomainEvent;

/**
 * Doménová událost vyvolaná auditním subsystémem pro řetězení auditních reakcí.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class AuditEvent extends DomainEvent {

    private final boolean success;

    /**
     * Vytvoří auditní událost s výsledkem operace.
     *
     * @param success příznak úspěchu auditované operace
     */
    public AuditEvent(boolean success) {
        this.success = success;
    }

    /**
     * Vrátí příznak, zda auditovaná operace proběhla úspěšně.
     *
     * @return {@code true} pokud operace proběhla úspěšně
     */
    public boolean isSuccess() {
        return success;
    }
}
