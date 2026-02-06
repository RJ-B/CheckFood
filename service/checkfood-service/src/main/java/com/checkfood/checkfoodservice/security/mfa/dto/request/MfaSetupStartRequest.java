package com.checkfood.checkfoodservice.security.mfa.dto.request;

import com.checkfood.checkfoodservice.security.mfa.entity.MfaMethodType;

import jakarta.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;

/**
 * Request pro zahájení MFA setupu.
 */
@Getter
@Setter
public class MfaSetupStartRequest {

    @NotNull(message = "MFA method is required")
    private MfaMethodType method;

}
