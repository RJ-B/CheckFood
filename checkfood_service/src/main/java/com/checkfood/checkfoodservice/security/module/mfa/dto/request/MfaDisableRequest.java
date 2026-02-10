package com.checkfood.checkfoodservice.security.module.mfa.dto.request;

import jakarta.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

/**
 * Request pro vypnutí MFA.
 */
@Getter
@Setter
public class MfaDisableRequest {

    @NotBlank(message = "Password is required")
    private String password;

}
