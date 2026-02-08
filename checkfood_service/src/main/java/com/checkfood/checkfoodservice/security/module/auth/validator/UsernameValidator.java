package com.checkfood.checkfoodservice.security.module.auth.validator;

import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;
import com.checkfood.checkfoodservice.security.module.auth.policy.UsernamePolicy;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;

/**
 * Validátor uživatelského jména (emailové adresy).
 * Deleguje validační logiku na UsernamePolicy a transformuje výsledek na výjimku.
 *
 * @see UsernamePolicy
 */
@Component
@RequiredArgsConstructor
public class UsernameValidator {

    private final UsernamePolicy usernamePolicy;

    /**
     * Validuje emailovou adresu podle pravidel systému.
     * Kontroluje formát podle RFC standardu a maximální délku.
     *
     * @param email emailová adresa k validaci
     * @throws AuthException pokud email není ve validním formátu
     */
    public void validate(String email) {

        if (!usernamePolicy.isValid(email)) {
            throw AuthException.invalidEmailFormat();
        }
    }
}