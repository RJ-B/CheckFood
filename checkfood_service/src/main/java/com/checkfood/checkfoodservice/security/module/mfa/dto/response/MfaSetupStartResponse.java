package com.checkfood.checkfoodservice.security.module.mfa.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 * Odpověď při zahájení MFA setupu.
 */
@Getter
@Setter
@AllArgsConstructor
public class MfaSetupStartResponse {

    private String qrCode;

    private String secret;

}
