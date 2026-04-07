package com.checkfood.checkfoodservice.client.payment;

import com.checkfood.checkfoodservice.client.payment.model.PaymentRequest;
import com.checkfood.checkfoodservice.client.payment.model.PaymentResponse;

/**
 * Implementace PaymentClient pro platební bránu Stripe.
 * Obsahuje pouze mapování request/response a technické volání Stripe API.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class StripePaymentClient implements PaymentClient {

    /**
     * Provede platbu přes Stripe API.
     *
     * @param request požadavek na provedení platby
     * @return výsledek platební operace ze Stripe
     */
    @Override
    public PaymentResponse pay(PaymentRequest request) {
        // TODO: Stripe API volání
        return null;
    }
}
