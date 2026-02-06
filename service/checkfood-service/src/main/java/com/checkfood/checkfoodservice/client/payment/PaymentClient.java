package com.checkfood.checkfoodservice.client.payment;

import com.checkfood.checkfoodservice.client.payment.model.PaymentRequest;
import com.checkfood.checkfoodservice.client.payment.model.PaymentResponse;

/**
 * Abstraktní kontrakt pro platební systémy.
 *
 * Service vrstva:
 * - nikdy neřeší konkrétního poskytovatele
 * - pracuje pouze s tímto rozhraním
 */
public interface PaymentClient {

    PaymentResponse pay(PaymentRequest request);
}
