package com.checkfood.checkfoodservice.security.module.auth.policy;

import org.springframework.stereotype.Component;

/**
 * Password policy validator implementující security requirements pro user passwords.
 *
 * Definuje a enforces minimum security standards pro password complexity
 * podle industry best practices. Poskytuje both validation logic a
 * user-friendly requirement descriptions.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class PasswordPolicy {

    /**
     * Minimum password length podle security guidelines.
     */
    private static final int MIN_LENGTH = 8;

    /**
     * Maximum password length pro DoS protection a database constraints.
     */
    private static final int MAX_LENGTH = 64;

    /**
     * Strong password regex requiring:
     * - Alespoň jedno lowercase letter
     * - Alespoň jedno uppercase letter
     * - Alespoň jednu digit
     * - Alespoň jeden special character
     * - Minimum 8 characters total
     */
    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";

    /**
     * Validuje password podle defined security policy.
     *
     * Checks length constraints a character complexity requirements.
     * Used v registration a password change workflows.
     *
     * @param password password string pro validation
     * @return true pokud password meets všechny requirements
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
     * Provides user-friendly description of password requirements.
     *
     * Used pro validation error messages a UI hint text
     * pro clear user guidance na password creation.
     *
     * @return localized requirements message
     */
    public String getRequirementsMessage() {
        return String.format("""
                Heslo musí mít %d až %d znaků a obsahovat alespoň jedno velké písmeno, \
                malé písmeno, číslici a speciální znak (@$!%%*?&).""",
                MIN_LENGTH, MAX_LENGTH
        );
    }
}