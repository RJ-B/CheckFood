package com.checkfood.checkfoodservice.security.mfa.dto.request;

import jakarta.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

/**
 * Request pro ověření MFA challenge.
 */
@Getter
@Setter
public class MfaChallengeVerifyRequest {

    @NotBlank(message = "Code is required")
    private String code;

}
