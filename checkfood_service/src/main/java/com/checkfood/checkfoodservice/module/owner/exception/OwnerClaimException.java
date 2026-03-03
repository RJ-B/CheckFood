package com.checkfood.checkfoodservice.module.owner.exception;

import lombok.Getter;

@Getter
public class OwnerClaimException extends RuntimeException {

    private final OwnerClaimErrorCode errorCode;

    public OwnerClaimException(OwnerClaimErrorCode errorCode) {
        super(errorCode.getMessage());
        this.errorCode = errorCode;
    }

    public static OwnerClaimException companyNotFound() {
        return new OwnerClaimException(OwnerClaimErrorCode.COMPANY_NOT_FOUND);
    }

    public static OwnerClaimException restaurantNotFound() {
        return new OwnerClaimException(OwnerClaimErrorCode.RESTAURANT_NOT_FOUND);
    }

    public static OwnerClaimException identityMismatch() {
        return new OwnerClaimException(OwnerClaimErrorCode.IDENTITY_MISMATCH);
    }

    public static OwnerClaimException alreadyClaimed() {
        return new OwnerClaimException(OwnerClaimErrorCode.ALREADY_CLAIMED);
    }

    public static OwnerClaimException invalidCode() {
        return new OwnerClaimException(OwnerClaimErrorCode.INVALID_CODE);
    }

    public static OwnerClaimException codeExpired() {
        return new OwnerClaimException(OwnerClaimErrorCode.CODE_EXPIRED);
    }

    public static OwnerClaimException notOwnerRole() {
        return new OwnerClaimException(OwnerClaimErrorCode.NOT_OWNER_ROLE);
    }
}
