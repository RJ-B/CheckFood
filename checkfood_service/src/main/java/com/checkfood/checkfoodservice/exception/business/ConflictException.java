package com.checkfood.checkfoodservice.exception.business;

/**
 * Business konflikt (např. duplicitní stav).
 *
 * Typicky mapováno na HTTP 409.
 */
public class ConflictException extends BusinessException {

    public ConflictException(String message) {
        super(message);
    }
}
