package com.checkfood.checkfoodservice.security.refresh.exception;

/**
 * Výjimka vyhozená při neplatném refresh tokenu.
 */
public class InvalidRefreshTokenException extends RuntimeException {

    public InvalidRefreshTokenException(String message) {
        super(message);
    }

}
