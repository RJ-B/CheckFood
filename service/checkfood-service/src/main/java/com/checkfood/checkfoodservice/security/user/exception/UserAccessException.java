package com.checkfood.checkfoodservice.security.user.exception;

/**
 * Výjimka pro neoprávněný přístup k uživatelským datům.
 */
public class UserAccessException extends RuntimeException {

    public UserAccessException(String message) {
        super(message);
    }

}
