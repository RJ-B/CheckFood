package com.checkfood.checkfoodservice.exception.api;

/**
 * Výjimka reprezentující HTTP 400 – Bad Request.
 *
 * Používá se při:
 * - neplatném vstupu
 * - porušení validačních pravidel
 */
public class BadRequestApiException extends ApiException {

    public BadRequestApiException(String message) {
        super(message);
    }
}
