package com.checkfood.checkfoodservice.security.module.mfa.dto.request;

import jakarta.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

/**
 * DTO pro deaktivaci MFA obsahující aktuální heslo uživatele pro ověření identity.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
public class MfaDisableRequest {

    @NotBlank(message = "Password is required")
    private String password;

}
