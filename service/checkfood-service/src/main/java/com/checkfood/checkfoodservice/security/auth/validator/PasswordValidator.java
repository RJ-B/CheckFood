package com.checkfood.checkfoodservice.security.auth.validator;

import com.checkfood.checkfoodservice.security.auth.policy.PasswordPolicy;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;

/**
 * Validátor síly hesla.
 *
 * Používá PasswordPolicy a v případě neúspěchu
 * vyhazuje výjimku.
 */
@Component
@RequiredArgsConstructor
public class PasswordValidator {

    private final PasswordPolicy passwordPolicy;


    /**
     * Validuje heslo podle bezpečnostních pravidel.
     */
    public void validate(String password) {

        if (!passwordPolicy.isValid(password)) {
            throw new IllegalArgumentException(
                    "Password does not meet security requirements"
            );
        }
    }

}
