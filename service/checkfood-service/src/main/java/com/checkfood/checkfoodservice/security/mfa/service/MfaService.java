package com.checkfood.checkfoodservice.security.mfa.service;

import com.checkfood.checkfoodservice.security.mfa.dto.response.MfaChallengeResponse;
import com.checkfood.checkfoodservice.security.mfa.dto.response.MfaSetupStartResponse;
import com.checkfood.checkfoodservice.security.mfa.dto.response.MfaStatusResponse;

/**
 * Service pro správu MFA.
 */
public interface MfaService {

    /**
     * Zahájí nastavení MFA (vygeneruje secret + QR).
     */
    MfaSetupStartResponse startSetup(Long userId);

    /**
     * Potvrdí MFA nastavení zadáním TOTP kódu.
     */
    void verifySetup(Long userId, String code);

    /**
     * Ověří MFA při přihlášení.
     */
    MfaChallengeResponse verifyChallenge(Long userId, String code);

    /**
     * Vypne MFA.
     */
    void disable(Long userId, String password);

    /**
     * Vrátí stav MFA.
     */
    MfaStatusResponse getStatus(Long userId);

}
