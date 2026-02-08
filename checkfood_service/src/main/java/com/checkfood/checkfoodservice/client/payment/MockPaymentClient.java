package com.checkfood.checkfoodservice.client.payment;

import com.checkfood.checkfoodservice.client.payment.model.PaymentRequest;
import com.checkfood.checkfoodservice.client.payment.model.PaymentResponse;

/**
 * Mock implementace platebního klienta.
 *
 * Používá se:
 * - v testech
 * - v local profilu
 */
public class MockPaymentClient implements PaymentClient {

    @Override
    public PaymentResponse pay(PaymentRequest request) {
        // TODO:
        // - simulovaná odpověď
        return null;
    }
}
