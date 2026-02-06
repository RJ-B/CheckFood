package com.checkfood.checkfoodservice.security.user.validator;

import com.checkfood.checkfoodservice.security.user.dto.request.ChangePasswordRequest;

import org.springframework.stereotype.Component;

/**
 * Validátor změny hesla uživatele.
 *
 * Řeší business pravidla nad rámec @Valid anotací.
 */
@Component
public class ChangePasswordValidator {

    public void validate(ChangePasswordRequest request) {

        if (request == null) {
            throw new IllegalArgumentException("Request must not be null");
        }

        // Kontrola shody nového hesla
        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw new IllegalArgumentException("New passwords do not match");
        }

        // Ochrana proti opětovnému použití starého hesla
        if (request.getCurrentPassword()
                .equals(request.getNewPassword())) {

            throw new IllegalArgumentException(
                    "New password must be different from current password"
            );
        }
    }

}
