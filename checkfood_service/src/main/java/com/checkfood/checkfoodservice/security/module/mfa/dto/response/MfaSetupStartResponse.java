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

    /**
     * {@code otpauth://} URI string suitable for display as a QR code by
     * the mobile client. Field name is {@code qrPayload} — it's not a
     * rendered QR image, it's the payload the client encodes into one.
     */
    private String qrPayload;

    private String secret;

}
