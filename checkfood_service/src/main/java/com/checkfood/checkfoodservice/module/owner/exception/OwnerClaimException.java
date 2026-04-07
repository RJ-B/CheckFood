package com.checkfood.checkfoodservice.module.owner.exception;

import lombok.Getter;

/**
 * Výjimka pro chyby vzniklé v průběhu procesu přiřazení restaurace majiteli.
 * Poskytuje statické factory metody pro běžné chybové scénáře.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
public class OwnerClaimException extends RuntimeException {

    private final OwnerClaimErrorCode errorCode;

    /**
     * Vytvoří výjimku s daným chybovým kódem.
     *
     * @param errorCode chybový kód určující typ chyby a HTTP status
     */
    public OwnerClaimException(OwnerClaimErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }

    /**
     * @return výjimka pro případ, kdy firma nebyla nalezena v ARES
     */
    public static OwnerClaimException companyNotFound() {
        return new OwnerClaimException(OwnerClaimErrorCode.COMPANY_NOT_FOUND);
    }

    /**
     * @return výjimka pro případ, kdy restaurace s daným IČO nebyla nalezena
     */
    public static OwnerClaimException restaurantNotFound() {
        return new OwnerClaimException(OwnerClaimErrorCode.RESTAURANT_NOT_FOUND);
    }

    /**
     * @return výjimka pro případ, kdy identita z BankID neodpovídá žádnému statutárnímu orgánu
     */
    public static OwnerClaimException identityMismatch() {
        return new OwnerClaimException(OwnerClaimErrorCode.IDENTITY_MISMATCH);
    }

    /**
     * @return výjimka pro případ, kdy je restaurace již přiřazena jinému majiteli
     */
    public static OwnerClaimException alreadyClaimed() {
        return new OwnerClaimException(OwnerClaimErrorCode.ALREADY_CLAIMED);
    }

    /**
     * @return výjimka pro případ neplatného ověřovacího kódu
     */
    public static OwnerClaimException invalidCode() {
        return new OwnerClaimException(OwnerClaimErrorCode.INVALID_CODE);
    }

    /**
     * @return výjimka pro případ, kdy platnost ověřovacího kódu vypršela
     */
    public static OwnerClaimException codeExpired() {
        return new OwnerClaimException(OwnerClaimErrorCode.CODE_EXPIRED);
    }

    /**
     * @return výjimka pro případ, kdy uživatel nemá roli OWNER
     */
    public static OwnerClaimException notOwnerRole() {
        return new OwnerClaimException(OwnerClaimErrorCode.NOT_OWNER_ROLE);
    }
}
