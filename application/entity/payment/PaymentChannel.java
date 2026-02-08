package com.checkfood.checkfoodservice.application.entity.payment;

public enum PaymentChannel {

    /**
     * Platba iniciovaná zákazníkem přes QR kód.
     */
    QR,

    /**
     * Platba zadaná obsluhou.
     */
    WAITER,

    /**
     * Objednávka mimo stůl (např. takeaway).
     */
    TAKEAWAY
}
