package com.checkfood.checkfoodservice.application.controller.payment;

import com.checkfood.checkfoodservice.application.dto.request.payment.PaymentCallbackRequestDto;
import com.checkfood.checkfoodservice.application.dto.request.payment.PaymentInitiateRequestDto;
import com.checkfood.checkfoodservice.application.dto.response.payment.PaymentResponseDto;
import com.checkfood.checkfoodservice.application.service.payment.PaymentService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * REST controller pro práci s platbami.
 *
 * <br><br>
 * PaymentController slouží jako HTTP adaptér
 * aplikační vrstvy pro agregát Payment.
 *
 * <br><br>
 * Zodpovědnosti controlleru:
 * <br>
 * - mapování HTTP požadavků na aplikační service,
 * <br>
 * - spuštění validace vstupních DTO,
 * <br>
 * - předání zpracování platebního procesu
 *   do servisní vrstvy.
 *
 * <br><br>
 * Controller:
 * <br>
 * - neobsahuje business logiku,
 * <br>
 * - neřeší stavové přechody platby,
 * <br>
 * - nekomunikuje s platební bránou,
 * <br>
 * - neřídí transakce.
 *
 * <br><br>
 * Cross-cutting připravenost:
 * <br>
 * - validation: @Valid (aktivní),
 * <br>
 * - security: připraveno pro ochranu endpointů (TODO),
 * <br>
 * - audit: řešeno v service vrstvě,
 * <br>
 * - logging: řešeno globálně (filter / interceptor),
 * <br>
 * - exception handling: řešeno přes @ControllerAdvice.
 */
@RestController
@RequestMapping("/api/payments")
@RequiredArgsConstructor
public class PaymentController {

    /**
     * Aplikační service pro práci s agregátem Payment.
     *
     * Controller komunikuje výhradně
     * přes rozhraní service vrstvy.
     */
    private final PaymentService paymentService;

    /**
     * Zahájí proces platby k objednávce.
     *
     * <br><br>
     * HTTP:
     * <br>
     * POST /api/payments
     *
     * <br><br>
     * Endpoint slouží k:
     * <br>
     * - vytvoření platebního záznamu,
     * <br>
     * - inicializaci platebního procesu
     *   (např. vytvoření QR / online platby).
     *
     * <br><br>
     * Controller:
     * <br>
     * - neověřuje stav objednávky,
     * <br>
     * - neřeší idempotenci,
     * <br>
     * - nekomunikuje s platební bránou.
     *
     * @param request vstupní DTO pro zahájení platby
     * @return detail vytvořené platby
     */
    @PostMapping
    public PaymentResponseDto initiatePayment(
            @Valid @RequestBody PaymentInitiateRequestDto request
    ) {
        // TODO security: omezení přístupu (USER / STAFF / SYSTEM)
        return paymentService.initiatePayment(request);
    }

    /**
     * Zpracuje callback z externí platební brány.
     *
     * <br><br>
     * HTTP:
     * <br>
     * POST /api/payments/callback
     *
     * <br><br>
     * Endpoint je určen výhradně
     * pro komunikaci s externím
     * platebním systémem.
     *
     * <br><br>
     * Controller:
     * <br>
     * - neověřuje podpis callbacku,
     * <br>
     * - neřeší idempotenci callbacku,
     * <br>
     * - nepřevádí stav platby.
     *
     * Veškerá logika je delegována
     * do servisní vrstvy.
     *
     * @param request callback DTO z platební brány
     */
    @PostMapping("/callback")
    public void handlePaymentCallback(
            @Valid @RequestBody PaymentCallbackRequestDto request
    ) {
        // TODO security: ověření původu callbacku (signature / IP whitelist)
        paymentService.handlePaymentCallback(request);
    }

    /**
     * Vrátí detail platby.
     *
     * <br><br>
     * HTTP:
     * <br>
     * GET /api/payments/{paymentId}
     *
     * <br><br>
     * Používá se:
     * <br>
     * - pro náhled platby zákazníkem,
     * <br>
     * - pro obsluhu restaurace,
     * <br>
     * - pro administrativní účely.
     *
     * @param paymentId identifikátor platby
     * @return detail platby
     */
    @GetMapping("/{paymentId}")
    public PaymentResponseDto getPaymentDetail(
            @PathVariable UUID paymentId
    ) {
        // TODO security: kontrola oprávnění k zobrazení platby
        return paymentService.getPaymentDetail(paymentId);
    }
}
