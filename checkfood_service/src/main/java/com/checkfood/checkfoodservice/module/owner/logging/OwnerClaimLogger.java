package com.checkfood.checkfoodservice.module.owner.logging;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * Logovací komponenta pro kroky procesu přiřazení restaurace majiteli.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
public class OwnerClaimLogger {

    /**
     * Zaloguje zahájení vyhledávání v ARES pro dané IČO.
     *
     * @param ico identifikační číslo osoby (IČO)
     */
    public void logAresLookup(String ico) {
        log.info("[OwnerClaim] ARES lookup for ICO: {}", ico);
    }

    /**
     * Zaloguje zahájení ověření přes BankID pro daného uživatele.
     *
     * @param userId identifikátor uživatele
     */
    public void logBankIdVerification(Long userId) {
        log.info("[OwnerClaim] BankID verification for userId: {}", userId);
    }

    /**
     * Zaloguje úspěšnou shodu identity uživatele se statutárním orgánem.
     *
     * @param userId identifikátor uživatele
     * @param ico    identifikační číslo osoby (IČO)
     */
    public void logIdentityMatch(Long userId, String ico) {
        log.info("[OwnerClaim] Identity MATCHED: userId={}, ICO={}", userId, ico);
    }

    /**
     * Zaloguje neshodu identity uživatele se statutárním orgánem.
     *
     * @param userId identifikátor uživatele
     * @param ico    identifikační číslo osoby (IČO)
     */
    public void logIdentityMismatch(Long userId, String ico) {
        log.info("[OwnerClaim] Identity MISMATCH: userId={}, ICO={}", userId, ico);
    }

    /**
     * Zaloguje odeslání e-mailového ověřovacího kódu.
     *
     * @param ico    identifikační číslo osoby (IČO)
     * @param userId identifikátor uživatele
     */
    public void logEmailCodeSent(String ico, Long userId) {
        log.info("[OwnerClaim] Email verification code sent: ICO={}, userId={}", ico, userId);
    }

    /**
     * Zaloguje úspěšné ověření e-mailového kódu.
     *
     * @param ico    identifikační číslo osoby (IČO)
     * @param userId identifikátor uživatele
     */
    public void logEmailCodeVerified(String ico, Long userId) {
        log.info("[OwnerClaim] Email code verified: ICO={}, userId={}", ico, userId);
    }

    /**
     * Zaloguje vytvoření členství majitele v restauraci.
     *
     * @param userId       identifikátor uživatele
     * @param restaurantId identifikátor restaurace
     */
    public void logMembershipCreated(Long userId, String restaurantId) {
        log.info("[OwnerClaim] Membership created: userId={}, restaurantId={}", userId, restaurantId);
    }
}
