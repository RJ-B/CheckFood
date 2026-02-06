package com.checkfood.checkfoodservice.application.dto.validation.validator;

import com.checkfood.checkfoodservice.application.dto.validation.annotation.ValidReservationTime;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

/**
 * Validator pro kontrolu časového rozsahu rezervace.
 */
public class ReservationTimeValidator implements ConstraintValidator<ValidReservationTime, Object> {

    @Override
    public boolean isValid(Object value, ConstraintValidatorContext context) {
        // TODO:
        // - získat from / to
        // - kontrola from < to
        // - kontrola against now()
        return true;
    }
}
