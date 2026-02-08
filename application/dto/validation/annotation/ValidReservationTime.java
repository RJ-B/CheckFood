package com.checkfood.checkfoodservice.application.dto.validation.annotation;

import com.checkfood.checkfoodservice.application.dto.validation.validator.ReservationTimeValidator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

/**
 * Validace časového rozsahu rezervace.
 *
 * Kontroluje:
 * - from < to
 * - rezervace není v minulosti
 */
@Documented
@Constraint(validatedBy = ReservationTimeValidator.class)
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidReservationTime {

    String message() default "Invalid reservation time range";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
