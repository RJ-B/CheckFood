package com.checkfood.checkfoodservice.security.user.exception;

/**
 * Výjimka vyhozená při nenalezení uživatele.
 */
public class UserNotFoundException extends RuntimeException {

    public UserNotFoundException(String message) {
        super(message);
    }

}
