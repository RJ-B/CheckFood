package com.checkfood.checkfoodservice.client.payment;

import com.checkfood.checkfoodservice.client.payment.model.PaymentRequest;
import com.checkfood.checkfoodservice.client.payment.model.PaymentResponse;

/**
 * Mock implementace platebního klienta pro testy a lokální profil.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class MockPaymentClient implements PaymentClient {

    /**
     * Vrátí simulovanou platební odpověď.
     *
     * @param request požadavek na provedení platby
     * @return simulovaná odpověď
     */
    @Override
    public PaymentResponse pay(PaymentRequest request) {
        // TODO: simulovaná odpověď
        return null;
    }
}
