package com.checkfood.checkfoodservice.exception.api;

/**
 * Základní výjimka pro chyby, které jsou
 * propagovány až na REST API vrstvu.
 *
 * Každá ApiException:
 * - odpovídá konkrétnímu HTTP statusu
 * - je bezpečná pro klienta (neodhaluje interní detaily)
 */
public abstract class ApiException extends RuntimeException {

    protected ApiException(String message) {
        super(message);
    }
}
