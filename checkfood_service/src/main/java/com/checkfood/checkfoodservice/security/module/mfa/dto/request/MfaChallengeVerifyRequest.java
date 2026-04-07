package com.checkfood.checkfoodservice.security.module.mfa.dto.request;

import jakarta.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

/**
 * DTO pro ověření MFA přihlašovací výzvy obsahující TOTP nebo záložní kód.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
public class MfaChallengeVerifyRequest {

    @NotBlank(message = "Code is required")
    private String code;

}
