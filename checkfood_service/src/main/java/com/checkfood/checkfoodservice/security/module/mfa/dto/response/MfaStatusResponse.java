package com.checkfood.checkfoodservice.security.module.mfa.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 * Stav MFA účtu.
 */
@Getter
@Setter
@AllArgsConstructor
public class MfaStatusResponse {

    private boolean enabled;

}
