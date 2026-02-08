package com.checkfood.checkfoodservice.security.module.mfa.dto.request;

import jakarta.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

/**
 * Request pro potvrzení MFA setupu.
 */
@Getter
@Setter
public class MfaSetupVerifyRequest {

    @NotBlank(message = "Code is required")
    private String code;

}
