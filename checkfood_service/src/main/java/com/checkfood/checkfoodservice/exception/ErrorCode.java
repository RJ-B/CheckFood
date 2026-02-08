package com.checkfood.checkfoodservice.exception;

/**
 * Obecné chybové kódy pro celou aplikaci.
 * Poskytuje standardizované identifikátory chyb použitelné napříč všemi vrstvami.
 */
public enum ErrorCode {

    /**
     * Validační chyba vstupních dat.
     */
    VALIDATION_ERROR,

    /**
     * Požadovaný zdroj nebyl nalezen.
     */
    NOT_FOUND,

    /**
     * Interní chyba serveru.
     */
    INTERNAL_SERVER_ERROR,

    /**
     * Chyba komunikace s databází.
     */
    DATABASE_ERROR,

    /**
     * Chyba komunikace s externím servisem.
     */
    EXTERNAL_SERVICE_ERROR,

    /**
     * Neplatný formát dat.
     */
    INVALID_FORMAT,

    /**
     * Operace není povolena v aktuálním stavu.
     */
    OPERATION_NOT_ALLOWED,

    /**
     * Konflikt s existujícími daty.
     */
    CONFLICT
}