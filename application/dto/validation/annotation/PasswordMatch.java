package com.checkfood.checkfoodservice.application.dto.validation.annotation;

import com.checkfood.checkfoodservice.application.dto.validation.validator.PasswordMatchValidator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

/**
 * Validace shody hesel (např. password + confirmation).
 *
 * Používá se na celé DTO.
 */
@Documented
@Constraint(validatedBy = PasswordMatchValidator.class)
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
public @interface PasswordMatch {

    String message() default "Passwords do not match";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
