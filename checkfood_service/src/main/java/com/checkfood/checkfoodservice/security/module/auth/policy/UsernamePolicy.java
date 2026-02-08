package com.checkfood.checkfoodservice.security.module.auth.policy;

import org.springframework.stereotype.Component;

import java.util.regex.Pattern;

/**
 * Validátor pro kontrolu formátu emailových adres.
 * V systému slouží email jako přihlašovací jméno (username).
 */
@Component
public class UsernamePolicy {

    /**
     * RFC-kompatibilní regex pro validaci emailových adres.
     * Zjednodušená verze pokrývající běžné formáty.
     */
    private static final String EMAIL_REGEX =
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile(EMAIL_REGEX);

    /**
     * Maximální délka emailové adresy podle RFC 5321.
     * Ochrana proti DoS útokům s extrémně dlouhými emaily.
     */
    private static final int MAX_LENGTH = 254;

    /**
     * Ověří, zda je email validní podle pravidel systému.
     * Kontroluje formát podle regex a maximální délku.
     *
     * @param email emailová adresa k validaci
     * @return true pokud email splňuje všechny požadavky, jinak false
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