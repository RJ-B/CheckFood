package com.checkfood.checkfoodservice.security.module.auth.validator;

import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;
import com.checkfood.checkfoodservice.security.module.auth.policy.PasswordPolicy;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;

/**
 * Validátor síly hesla podle definované bezpečnostní politiky.
 * Deleguje validační logiku na PasswordPolicy a transformuje výsledek na výjimku.
 *
 * @see PasswordPolicy
 */
@Component
@RequiredArgsConstructor
public class PasswordValidator {

    private final PasswordPolicy passwordPolicy;

    /**
     * Validuje heslo podle bezpečnostních pravidel definovaných v PasswordPolicy.
     * Kontroluje minimální délku, složitost a další požadavky.
     *
     * @param password heslo k validaci
     * @throws AuthException pokud heslo nesplňuje bezpečnostní požadavky
     */
    public void validate(String password) {

        if (!passwordPolicy.isValid(password)) {
            throw AuthException.weakPassword();
        }
    }
}