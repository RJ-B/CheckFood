package com.checkfood.checkfoodservice.application.service.payment;

import com.checkfood.checkfoodservice.application.dto.request.payment.PaymentCallbackRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.payment.PaymentInitiateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.payment.PaymentResponseDto;

import java.util.UUID;

/**
 * Aplikační service pro práci s agregátem Payment.
 *
 * <br><br>
 * Payment reprezentuje platební transakci
 * spojenou s konkrétní objednávkou.
 *
 * <br><br>
 * Service zodpovídá za:
 * <br>
 * - inicializaci platby,
 * <br>
 * - zpracování platebního callbacku,
 * <br>
 * - čtení stavu platby.
 */
public interface PaymentService {

    /**
     * Inicializuje novou platbu k objednávce.
     *
     * @param request vstupní data platby
     * @return informace o vytvořené platbě
     */
    PaymentResponseDto initiatePayment(PaymentInitiateRequestDto request);

    /**
     * Zpracuje callback z platební brány.
     *
     * <br><br>
     * Metoda aktualizuje stav platby
     * na základě odpovědi externí služby.
     *
     * @param request callback data
     */
    void handlePaymentCallback(PaymentCallbackRequestDto request);

    /**
     * Vrátí detail platby.
     *
     * @param paymentId identifikátor platby
     * @return detail platby
     */
    PaymentResponseDto getPaymentDetail(UUID paymentId);
}
