package com.checkfood.checkfoodservice.exception.api;

/**
 * HTTP 401 – Unauthorized.
 *
 * Používá se při:
 * - chybějící autentizaci
 * - neplatném tokenu
 */
public class UnauthorizedApiException extends ApiException {

    public UnauthorizedApiException(String message) {
        super(message);
    }
}
