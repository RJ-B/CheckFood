package com.checkfood.checkfoodservice.security.module.mfa.dto.request;

import com.checkfood.checkfoodservice.security.module.mfa.entity.MfaMethodType;

import jakarta.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;

/**
 * DTO pro zahájení nastavení MFA určující zvolenou metodu ověřování.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
public class MfaSetupStartRequest {

    @NotNull(message = "MFA method is required")
    private MfaMethodType method;

}
