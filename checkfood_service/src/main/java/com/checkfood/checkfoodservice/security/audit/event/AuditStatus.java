package com.checkfood.checkfoodservice.security.audit.event;

/**
 * Enumrace stavů výsledku auditované akce.
 * Určuje, zda byla akce úspěšně dokončena, selhala nebo byla zablokována.
 */
public enum AuditStatus {

    /**
     * Akce byla úspěšně dokončena.
     */
    SUCCESS,

    /**
     * Akce selhala z důvodu chyby nebo neplatných dat.
     */
    FAILED,

    /**
     * Akce byla zablokována bezpečnostním mechanismem (např. rate limiting).
     */
    BLOCKED

}