package com.checkfood.checkfoodservice.exception.business;

/**
 * Business validační výjimka.
 *
 * Používá se při porušení doménových pravidel,
 * nikoli při DTO validaci.
 */
public class ValidationException extends BusinessException {

    public ValidationException(String message) {
        super(message);
    }
}
