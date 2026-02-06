package com.checkfood.checkfoodservice.security.oauth.exception;

/**
 * Výjimka vyhozená, pokud OAuth provider neposkytne email,
 * který je potřeba pro spárování/vytvoření uživatele.
 */
public class OAuthEmailMissingException extends OAuthException {

    public OAuthEmailMissingException(String message) {
        super(message);
    }

}
