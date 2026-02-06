package com.checkfood.checkfoodservice.application.dto.validation.annotation;

import com.checkfood.checkfoodservice.application.dto.validation.validator.PasswordValidator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import java.lang.annotation.*;

/**
 * Vlastní validační anotace pro kontrolu hesla.
 *
 * Používá se v:
 * - UserRegisterRequestDto
 * - UserChangePasswordRequestDto
 *
 * Validuje:
 * - délku hesla
 * - složitost
 */
@Documented
@Constraint(validatedBy = PasswordValidator.class)
@Target({ ElementType.FIELD })
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidPassword {

    String message() default "Password does not meet security requirements";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
