package com.checkfood.checkfoodservice.security.user.exception;

/**
 * Výjimka vyhozená při nenalezení role.
 */
public class RoleNotFoundException extends RuntimeException {

    public RoleNotFoundException(String message) {
        super(message);
    }

}
