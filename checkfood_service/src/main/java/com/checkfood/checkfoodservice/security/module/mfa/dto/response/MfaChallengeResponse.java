package com.checkfood.checkfoodservice.security.module.mfa.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 * Odpověď po MFA ověření.
 */
@Getter
@Setter
@AllArgsConstructor
public class MfaChallengeResponse {

    private boolean success;

    public static MfaChallengeResponse success() {
        return new MfaChallengeResponse(true);
    }

}
