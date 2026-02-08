package com.checkfood.checkfoodservice.exception.business;

/**
 * Business výjimka pro neexistující entitu.
 *
 * Mapuje se typicky na HTTP 404.
 */
public class NotFoundException extends BusinessException {

    public NotFoundException(String message) {
        super(message);
    }
}
