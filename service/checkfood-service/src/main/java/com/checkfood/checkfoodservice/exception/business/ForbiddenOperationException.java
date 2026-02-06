package com.checkfood.checkfoodservice.exception.business;

/**
 * Pokus o nepovolenou business operaci.
 *
 * Např. změna objednávky v neplatném stavu.
 */
public class ForbiddenOperationException extends BusinessException {

    public ForbiddenOperationException(String message) {
        super(message);
    }
}
