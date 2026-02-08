package com.checkfood.checkfoodservice.application.entity.payment;

public enum PaymentMethod {

    /**
     * Hotovostní platba.
     */
    CASH,

    /**
     * Platba kartou (terminál).
     * Zatím bez přímé integrace.
     */
    CARD,

    /**
     * Online platba (QR / platební brána).
     */
    ONLINE
}
