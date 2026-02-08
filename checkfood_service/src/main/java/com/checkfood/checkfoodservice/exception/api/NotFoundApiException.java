package com.checkfood.checkfoodservice.exception.api;

/**
 * HTTP 404 – Not Found.
 *
 * Používá se, pokud požadovaný zdroj
 * neexistuje.
 */
public class NotFoundApiException extends ApiException {

    public NotFoundApiException(String message) {
        super(message);
    }
}
