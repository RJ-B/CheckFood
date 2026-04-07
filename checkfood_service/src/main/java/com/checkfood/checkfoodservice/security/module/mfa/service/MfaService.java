package com.checkfood.checkfoodservice.security.module.mfa.service;

import com.checkfood.checkfoodservice.security.module.mfa.dto.response.MfaChallengeResponse;
import com.checkfood.checkfoodservice.security.module.mfa.dto.response.MfaSetupStartResponse;
import com.checkfood.checkfoodservice.security.module.mfa.dto.response.MfaStatusResponse;

/**
 * Rozhraní servisní vrstvy pro správu vícefaktorové autentizace uživatelů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface MfaService {

    /**
     * Zahájí nastavení MFA — vygeneruje Base32 tajný klíč a QR kód pro autentizační aplikaci.
     *
     * @param userId ID uživatele
     * @return odpověď s QR payloadem a tajným klíčem
     */
    MfaSetupStartResponse startSetup(Long userId);

    /**
     * Potvrdí nastavení MFA zadáním prvního platného TOTP kódu z autentizační aplikace.
     *
     * @param userId ID uživatele
     * @param code   TOTP kód z autentizační aplikace
     */
    void verifySetup(Long userId, String code);

    /**
     * Ověří MFA kód (TOTP nebo záložní kód) při přihlašovací výzvě.
     *
     * @param userId ID uživatele
     * @param code   TOTP kód nebo záložní kód
     * @return odpověď s výsledkem ověření
     */
    MfaChallengeResponse verifyChallenge(Long userId, String code);

    /**
     * Deaktivuje MFA po ověření hesla uživatele a smaže všechny záložní kódy.
     *
     * @param userId   ID uživatele
     * @param password aktuální heslo uživatele pro ověření identity
     */
    void disable(Long userId, String password);

    /**
     * Vrátí aktuální stav MFA pro daného uživatele.
     *
     * @param userId ID uživatele
     * @return stav MFA (aktivní/neaktivní)
     */
    MfaStatusResponse getStatus(Long userId);

}
