package com.checkfood.checkfoodservice.security.user.validator;

import com.checkfood.checkfoodservice.security.user.dto.request.UpdateProfileRequest;
import org.springframework.stereotype.Component;

/**
 * Validátor aktualizace profilu uživatele.
 * Provádí byznys validace, které doplňují standardní JSR-303 anotace.
 */
@Component
public class UpdateProfileValidator {

    /**
     * Validuje data pro aktualizaci profilu.
     * Zaměřuje se na integritu jmen, aby nebyla tvořena pouze prázdnými znaky.
     */
    public void validate(UpdateProfileRequest request) {

        if (request == null) {
            throw new IllegalArgumentException("Požadavek (request) nesmí být null.");
        }

        // Validace křestního jména, pokud je přítomno v requestu
        if (request.getFirstName() != null && request.getFirstName().isBlank()) {
            throw new IllegalArgumentException("Křestní jméno nesmí být tvořeno pouze prázdnými znaky.");
        }

        // Validace příjmení, pokud je přítomno v requestu
        if (request.getLastName() != null && request.getLastName().isBlank()) {
            throw new IllegalArgumentException("Příjmení nesmí být tvořeno pouze prázdnými znaky.");
        }
    }
}