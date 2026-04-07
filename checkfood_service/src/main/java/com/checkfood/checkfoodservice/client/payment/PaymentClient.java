package com.checkfood.checkfoodservice.client.payment;

import com.checkfood.checkfoodservice.client.payment.model.PaymentRequest;
import com.checkfood.checkfoodservice.client.payment.model.PaymentResponse;

/**
 * Abstraktní kontrakt pro platební systémy.
 * Service vrstva pracuje výhradně s tímto rozhraním a nezná konkrétního payment provider.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface PaymentClient {

    /**
     * Provede platbu podle zadaného požadavku.
     *
     * @param request požadavek na provedení platby
     * @return výsledek platební operace
     */
    PaymentResponse pay(PaymentRequest request);
}
