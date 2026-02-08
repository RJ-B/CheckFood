package com.checkfood.checkfoodservice.security.module.user.validator;

import com.checkfood.checkfoodservice.security.module.user.dto.request.ChangePasswordRequest;
import com.checkfood.checkfoodservice.security.module.user.exception.UserException;

import org.springframework.stereotype.Component;

/**
 * Validátor pro změnu hesla uživatele.
 * Řeší business pravidla nad rámec základních @Valid anotací.
 * Kontroluje shodu nového hesla s potvrzením a zajišťuje, že nové heslo je odlišné od současného.
 *
 * @see ChangePasswordRequest
 */
@Component
public class ChangePasswordValidator {

    /**
     * Provede komplexní validaci požadavku na změnu hesla.
     * Kontroluje shodu nového hesla s potvrzením a zajišťuje,
     * že uživatel nenastavuje stejné heslo jako aktuálně používá.
     *
     * @param request požadavek na změnu hesla
     * @throws UserException pokud validace selže
     */
    public void validate(ChangePasswordRequest request) {

        if (request == null) {
            throw UserException.invalidOperation("Request must not be null");
        }

        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw UserException.invalidOperation("New passwords do not match");
        }

        if (request.getCurrentPassword().equals(request.getNewPassword())) {
            throw UserException.invalidOperation(
                    "New password must be different from current password"
            );
        }
    }
}