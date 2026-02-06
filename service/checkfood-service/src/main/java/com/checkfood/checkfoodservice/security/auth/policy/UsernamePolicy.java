package com.checkfood.checkfoodservice.security.auth.policy;

import org.springframework.stereotype.Component;

import java.util.regex.Pattern;

/**
 * Politika pro validaci uživatelského jména.
 *
 * V systému slouží email jako login.
 */
@Component
public class UsernamePolicy {

    // Standardní RFC email regex (zjednodušený a bezpečný)
    private static final String EMAIL_REGEX =
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile(EMAIL_REGEX);

    // Maximální délka emailu (ochrana proti útokům)
    private static final int MAX_LENGTH = 254;


    /**
     * Ověří, zda je email validní podle pravidel systému.
     */
    public boolean isValid(String email) {

        if (email == null) {
            return false;
        }

        if (email.length() > MAX_LENGTH) {
            return false;
        }

        return EMAIL_PATTERN.matcher(email).matches();
    }

}
