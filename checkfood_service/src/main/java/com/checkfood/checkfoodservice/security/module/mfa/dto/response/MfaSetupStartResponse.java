package com.checkfood.checkfoodservice.security.module.mfa.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 * DTO odpovědi při zahájení nastavení MFA obsahující QR kód a tajný klíč pro ruční zadání.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@AllArgsConstructor
public class MfaSetupStartResponse {

    private String qrCode;

    private String secret;

}
