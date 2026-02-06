package com.checkfood.checkfoodservice.security.oauth.exception;

/**
 * Výjimka vyhozená při neplatném OAuth tokenu.
 */
public class OAuthTokenInvalidException extends OAuthException {

    public OAuthTokenInvalidException(String message) {
        super(message);
    }

    public OAuthTokenInvalidException(String message, Throwable cause) {
        super(message, cause);
    }

}
