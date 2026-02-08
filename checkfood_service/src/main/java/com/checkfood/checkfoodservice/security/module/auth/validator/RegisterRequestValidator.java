package com.checkfood.checkfoodservice.security.module.auth.validator;

import com.checkfood.checkfoodservice.security.module.auth.dto.request.RegisterRequest;
import com.checkfood.checkfoodservice.security.module.auth.exception.AuthException;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;

/**
 * Validátor registračních požadavků.
 * Provádí komplexní validaci vstupních dat před vytvořením nového uživatelského účtu.
 * Kontroluje shodu a sílu hesla, platnost emailu a jeho unikátnost v systému.
 *
 * @see PasswordValidator
 * @see UsernameValidator
 * @see UserService
 */
@Component
@RequiredArgsConstructor
public class RegisterRequestValidator {

    private final PasswordValidator passwordValidator;
    private final UsernameValidator usernameValidator;
    private final UserService userService;

    /**
     * Provede kompletní validaci registračního požadavku.
     * Kontroluje validitu hesla, shodu hesel, formát emailu a jeho unikátnost.
     *
     * @param request registrační požadavek k validaci
     * @throws AuthException při nesplnění validačních pravidel
     */
    public void validate(RegisterRequest request) {

        if (request == null) {
            throw AuthException.internalError("Register request must not be null");
        }

        validatePasswords(request);
        validateEmail(request);
    }

    /**
     * Kontroluje shodu hesel a sílu zadaného hesla.
     *
     * @param request registrační požadavek
     * @throws AuthException pokud se hesla neshodují nebo heslo nesplňuje bezpečnostní požadavky
     */
    private void validatePasswords(RegisterRequest request) {

        if (!request.getPassword().equals(request.getConfirmPassword())) {
            throw AuthException.passwordMismatch();
        }

        passwordValidator.validate(request.getPassword());
    }

    /**
     * Kontroluje platnost formátu emailu a jeho unikátnost v systému.
     *
     * @param request registrační požadavek
     * @throws AuthException pokud email není platný nebo je již registrován
     */
    private void validateEmail(RegisterRequest request) {

        usernameValidator.validate(request.getEmail());

        if (userService.existsByEmail(request.getEmail())) {
            throw AuthException.emailExists();
        }
    }
}