package com.checkfood.checkfoodservice.security.module.auth.policy;

import org.springframework.stereotype.Component;

import java.util.regex.Pattern;

/**
 * Email format validator pro username validation v authentication systému.
 *
 * V systému funguje email jako primary username identifier. Validuje
 * email format podle RFC standards s additional security constraints
 * pro DoS protection a database compatibility.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class UsernamePolicy {

    /**
     * RFC-compatible email regex covering common email formats.
     * Simplified version avoiding complex edge cases pro performance a security.
     */
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

    /**
     * Compiled pattern pro performance optimization v repeated validations.
     */
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    /**
     * Maximum email length podle RFC 5321 standard.
     * Provides DoS protection proti extrémně dlouhé email addresses.
     */
    private static final int MAX_LENGTH = 254;

    /**
     * Validates email format podle system requirements.
     *
     * Checks both regex pattern compliance a length constraints
     * pro comprehensive email validation.
     *
     * @param email email address pro validation
     * @return true pokud email meets všechny format requirements
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