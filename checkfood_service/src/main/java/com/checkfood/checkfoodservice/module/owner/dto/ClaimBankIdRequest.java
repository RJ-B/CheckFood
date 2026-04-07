package com.checkfood.checkfoodservice.module.owner.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Požadavek na ověření vlastnictví restaurace prostřednictvím BankID podle IČO.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
public class ClaimBankIdRequest {
    @NotBlank
    private String ico;
}
