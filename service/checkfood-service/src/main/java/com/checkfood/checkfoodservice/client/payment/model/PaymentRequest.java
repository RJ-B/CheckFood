package com.checkfood.checkfoodservice.client.payment.model;

/**
 * Požadavek na provedení platby směrem
 * k externímu platebnímu systému.
 */
public class PaymentRequest {

    private String orderId;
    private long amount;
    private String currency;

    // getters / setters
}
