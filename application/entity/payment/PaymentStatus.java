package com.checkfood.checkfoodservice.application.entity.payment;

/**
 * Stav platby.
 */
public enum PaymentStatus {

    /**
     * Platba vytvořena, ale ještě nezačala.
     */
    CREATED,

    /**
     * Probíhá proces platby (čekání na potvrzení).
     */
    PENDING,

    /**
     * Platba úspěšně dokončena.
     */
    PAID,

    /**
     * Platba selhala.
     */
    FAILED,

    /**
     * Platba zrušena.
     */
    CANCELLED,

    /**
     * Platba refundována (částečně nebo plně).
     */
    REFUNDED
}
