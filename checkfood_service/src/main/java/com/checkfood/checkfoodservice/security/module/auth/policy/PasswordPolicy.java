package com.checkfood.checkfoodservice.security.module.auth.policy;

import org.springframework.stereotype.Component;

/**
 * Validátor hesel pro kontrolu bezpečnostních požadavků na hesla uživatelů.
 * Definuje pravidla pro minimální délku, složitost a další bezpečnostní aspekty hesel.
 */
@Component
public class PasswordPolicy {

    private static final int MIN_LENGTH = 8;
    private static final int MAX_LENGTH = 64;

    /**
     * Regex pro silné heslo:
     * - Minimálně jedno velké písmeno
     * - Minimálně jedno malé písmeno
     * - Minimálně jedna číslice
     * - Minimálně jeden speciální znak
     */
    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";

    /**
     * Validuje heslo podle definované bezpečnostní politiky.
     * Heslo musí splňovat minimální délku a obsahovat kombinaci různých typů znaků.
     *
     * @param password heslo k validaci
     * @return true pokud heslo splňuje všechny požadavky, jinak false
     */
    public boolean isValid(String password) {
        if (password == null) {
            return false;
        }

        if (password.length() < MIN_LENGTH || password.length() > MAX_LENGTH) {
            return false;
        }

        return password.matches(PASSWORD_REGEX);
    }

    /**
     * Vrací chybovou zprávu popisující požadavky na heslo.
     *
     * @return lidsky čitelný popis požadavků na heslo
     */
    public String getRequirementsMessage() {
        return String.format(
                "Heslo musí mít %d až %d znaků a obsahovat alespoň jedno velké písmeno, " +
                        "malé písmeno, číslici a speciální znak (@$!%%*?&).",
                MIN_LENGTH, MAX_LENGTH
        );
    }
}