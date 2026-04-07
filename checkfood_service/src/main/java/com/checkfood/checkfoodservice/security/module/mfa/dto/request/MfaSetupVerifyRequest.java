package com.checkfood.checkfoodservice.security.module.mfa.dto.request;

import jakarta.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

/**
 * DTO pro potvrzení nastavení MFA obsahující první TOTP kód vygenerovaný autentizační aplikací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
public class MfaSetupVerifyRequest {

    @NotBlank(message = "Code is required")
    private String code;

}
