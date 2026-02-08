package com.checkfood.checkfoodservice.client.payment;

import com.checkfood.checkfoodservice.client.payment.model.PaymentRequest;
import com.checkfood.checkfoodservice.client.payment.model.PaymentResponse;

/**
 * Implementace PaymentClient pro Stripe.
 *
 * Obsahuje pouze:
 * - mapování request/response
 * - technické volání API
 */
public class StripePaymentClient implements PaymentClient {

    @Override
    public PaymentResponse pay(PaymentRequest request) {
        // TODO:
        // - Stripe API volání
        return null;
    }
}
