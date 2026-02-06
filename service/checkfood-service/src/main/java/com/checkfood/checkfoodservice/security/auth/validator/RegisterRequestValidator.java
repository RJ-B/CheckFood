package com.checkfood.checkfoodservice.security.auth.validator;

import com.checkfood.checkfoodservice.security.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.user.service.UserService;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;

/**
 * Validátor registračních požadavků.
 *
 * Ověřuje správnost vstupních dat
 * před vytvořením uživatele.
 */
@Component
@RequiredArgsConstructor
public class RegisterRequestValidator {

    // Validátor síly hesla
    private final PasswordValidator passwordValidator;

    // Validátor formátu emailu
    private final UsernameValidator usernameValidator;

    // Přístup k uživatelským datům (kontrola duplicity)
    private final UserService userService;


    /**
     * Provede kompletní validaci registračního požadavku.
     */
    public void validate(RegisterRequest request) {

        if (request == null) {
            throw new IllegalArgumentException("Register request must not be null");
        }

        validatePasswords(request);
        validateEmail(request);
    }


    /**
     * Kontrola shody a síly hesla.
     */
    private void validatePasswords(RegisterRequest request) {

        // Kontrola shody hesel
        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw new IllegalArgumentException("Passwords do not match");
        }

        // Kontrola síly hesla přes specializovaný validator
        passwordValidator.validate(request.getPassword());
    }


    /**
     * Kontrola platnosti a duplicity emailu.
     */
    private void validateEmail(RegisterRequest request) {

        // Kontrola formátu emailu
        usernameValidator.validate(request.getEmail());

        // Kontrola duplicity
        if (userService.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("Email is already registered");
        }
    }

}
