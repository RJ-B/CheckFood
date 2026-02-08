package com.checkfood.checkfoodservice.exception.api;

/**
 * HTTP 403 – Forbidden.
 *
 * Autentizace proběhla, ale uživatel
 * nemá oprávnění.
 */
public class ForbiddenApiException extends ApiException {

    public ForbiddenApiException(String message) {
        super(message);
    }
}
