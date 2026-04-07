package com.checkfood.checkfoodservice.module.owner.service;

import com.checkfood.checkfoodservice.module.owner.dto.AresLookupResponse;
import com.checkfood.checkfoodservice.module.owner.dto.ClaimResultResponse;

/**
 * Interface pro správu procesu přiřazení restaurace majiteli prostřednictvím ARES, BankID nebo e-mailového ověření.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface OwnerClaimService {

    /**
     * Vyhledá restauraci v ARES podle IČO a vrátí základní informace o firmě a restauraci.
     *
     * @param ico    identifikační číslo osoby (IČO)
     * @param userId identifikátor přihlášeného uživatele
     * @return informace o firmě a přidružené restauraci z ARES
     */
    AresLookupResponse lookupAres(String ico, Long userId);

    /**
     * Ověří identitu uživatele přes BankID a při shodě se statutárním orgánem vytvoří členství OWNER.
     *
     * @param ico    identifikační číslo osoby (IČO)
     * @param userId identifikátor přihlášeného uživatele
     * @return výsledek ověření včetně informace o případném e-mailovém fallbacku
     */
    ClaimResultResponse verifyBankId(String ico, Long userId);

    /**
     * Zahájí e-mailové ověření vlastnictví restaurace odesláním jednorázového kódu.
     *
     * @param ico    identifikační číslo osoby (IČO)
     * @param userId identifikátor přihlášeného uživatele
     * @return výsledek s informací o odeslání kódu a maskovanou e-mailovou adresou
     */
    ClaimResultResponse startEmailClaim(String ico, Long userId);

    /**
     * Potvrdí e-mailové ověření pomocí jednorázového kódu a vytvoří členství OWNER.
     *
     * @param ico    identifikační číslo osoby (IČO)
     * @param code   ověřovací kód zaslaný e-mailem
     * @param userId identifikátor přihlášeného uživatele
     * @return výsledek potvrzení ověření
     */
    ClaimResultResponse confirmEmailClaim(String ico, String code, Long userId);
}
