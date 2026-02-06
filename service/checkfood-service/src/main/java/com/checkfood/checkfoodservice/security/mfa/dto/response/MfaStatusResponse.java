package com.checkfood.checkfoodservice.security.mfa.dto.response;

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
