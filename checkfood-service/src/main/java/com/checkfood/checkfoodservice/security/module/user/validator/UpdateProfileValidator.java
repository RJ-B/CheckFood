package com.checkfood.checkfoodservice.security.module.user.validator;

import com.checkfood.checkfoodservice.security.module.user.dto.request.UpdateProfileRequest;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;
import org.springframework.stereotype.Component;

/**
 * Validátor pro aktualizaci uživatelského profilu.
 * Provádí byznys validace nad rámec standardních JSR-303 anotací.
 * Zajišťuje integritu jmen a zabraňuje nastavení prázdných hodnot.
 *
 * @see UpdateProfileRequest
 */
@Component
public class UpdateProfileValidator {

    /**
     * Validuje data pro aktualizaci profilu uživatele.
     * Kontroluje, že jména nejsou tvořena pouze whitespace znaky.
     *
     * @param request požadavek na aktualizaci profilu
     * @throws UserException pokud validace selže
     */
    public void validate(UpdateProfileRequest request) {

        if (request == null) {
            throw UserException.invalidOperation("Požadavek (request) nesmí být null.");
        }

        if (request.getFirstName() != null && request.getFirstName().isBlank()) {
            throw UserException.invalidOperation("Křestní jméno nesmí být tvořeno pouze prázdnými znaky.");
        }

        if (request.getLastName() != null && request.getLastName().isBlank()) {
            throw UserException.invalidOperation("Příjmení nesmí být tvořeno pouze prázdnými znaky.");
        }
    }
}