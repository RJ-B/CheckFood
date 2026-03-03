package com.checkfood.checkfoodservice.module.owner.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum OwnerClaimErrorCode {

    COMPANY_NOT_FOUND("Firma nebyla nalezena v ARES.", HttpStatus.NOT_FOUND),
    RESTAURANT_NOT_FOUND("Restaurace s danym ICO nebyla nalezena.", HttpStatus.NOT_FOUND),
    IDENTITY_MISMATCH("Identita neodpovida zadnemu statutarnimu organu.", HttpStatus.UNPROCESSABLE_ENTITY),
    ALREADY_CLAIMED("Restaurace je jiz prirazena.", HttpStatus.CONFLICT),
    INVALID_CODE("Neplatny overovaci kod.", HttpStatus.BAD_REQUEST),
    CODE_EXPIRED("Overovaci kod vyprsel.", HttpStatus.BAD_REQUEST),
    NOT_OWNER_ROLE("Uzivatel nema roli OWNER.", HttpStatus.FORBIDDEN);

    private final String message;
    private final HttpStatus status;
}
