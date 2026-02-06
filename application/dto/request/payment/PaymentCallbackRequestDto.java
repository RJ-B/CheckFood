package com.checkfood.checkfoodservice.application.dto.request.payment;

import jakarta.validation.constraints.NotBlank;

/**
 * DTO reprezentující callback
 * z externí platební brány.
 *
 * <br><br>
 * Objekt představuje vstupní kontrakt
 * cizího systému a není součástí domény.
 *
 * <br><br>
 * Hodnoty v tomto DTO:
 * <br>
 * - nejsou důvěryhodné,
 * <br>
 * - musí být validovány,
 * <br>
 * - jsou mapovány na doménový model
 *   až v aplikační service vrstvě.
 */
public record PaymentCallbackRequestDto(

        /**
         * Identifikátor transakce
         * v externím platebním systému.
         */
        @NotBlank
        String transactionId,

        /**
         * Stav platby vrácený
         * externí platební bránou.
         *
         * Očekávané hodnoty (příklad):
         * SUCCESS, FAILED, CANCELLED
         */
        @NotBlank
        String status,

        /**
         * Volitelná zpráva nebo kód chyby
         * vrácený platební bránou.
         */
        String message

) {
}
