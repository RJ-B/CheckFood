package com.checkfood.checkfoodservice.security.auth.policy;

import org.springframework.stereotype.Component;

@Component
public class PasswordPolicy {

    // Dočasně snížíme limity
    private static final int MIN_LENGTH = 3;

    // Regex už nepoužíváme, nebo dáme takový, co bere všechno
    // private static final String PASSWORD_REGEX = ... (zakomentováno)

    public boolean isValid(String password) {
        if (password == null) {
            return false;
        }

        // Jediná kontrola: heslo musí mít alespoň 3 znaky
        if (password.length() < MIN_LENGTH) {
            return false;
        }

        // Vždy vrátíme true = validace prošla
        return true;
    }
}