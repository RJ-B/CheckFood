package com.checkfood.checkfoodservice.application.dto.validation.validator;

import com.checkfood.checkfoodservice.application.dto.validation.annotation.PasswordMatch;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

/**
 * Validator pro kontrolu shody dvou hesel v DTO.
 */
public class PasswordMatchValidator implements ConstraintValidator<PasswordMatch, Object> {

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        // TODO:
        // - reflection / getter
        // - porovnání password vs confirmation
        return true;
    }
}
