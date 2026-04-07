package com.checkfood.checkfoodservice.security.module.mfa.dto.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

/**
 * DTO odpovědi po ověření MFA přihlašovací výzvy indikující výsledek operace.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@AllArgsConstructor
public class MfaChallengeResponse {

    private boolean success;

    /**
     * Vytvoří odpověď indikující úspěšné ověření MFA kódu.
     *
     * @return instance s příznakem úspěchu
     */
    public static MfaChallengeResponse success() {
        return new MfaChallengeResponse(true);
    }

}
