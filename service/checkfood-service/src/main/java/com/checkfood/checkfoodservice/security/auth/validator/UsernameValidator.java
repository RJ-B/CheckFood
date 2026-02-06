package com.checkfood.checkfoodservice.security.auth.validator;

import com.checkfood.checkfoodservice.security.auth.policy.UsernamePolicy;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;

/**
 * Validátor uživatelského jména (emailu).
 */
@Component
@RequiredArgsConstructor
public class UsernameValidator {

    private final UsernamePolicy usernamePolicy;


    /**
     * Validuje email podle pravidel systému.
     */
    public void validate(String email) {

        if (!usernamePolicy.isValid(email)) {
            throw new IllegalArgumentException("Invalid email format");
        }
    }

}
