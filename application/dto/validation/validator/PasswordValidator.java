package com.checkfood.checkfoodservice.application.dto.validation.validator;

import com.checkfood.checkfoodservice.application.dto.validation.annotation.ValidPassword;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

/**
 * Validator pro kontrolu síly hesla.
 */
public class PasswordValidator implements ConstraintValidator<ValidPassword, String> {

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        // TODO:
        // - kontrola minimální délky
        // - číslo
        // - velké písmeno
        // - speciální znak
        return true;
    }
}
