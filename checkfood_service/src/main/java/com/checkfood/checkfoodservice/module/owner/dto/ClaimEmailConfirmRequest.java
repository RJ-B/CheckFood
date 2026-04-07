package com.checkfood.checkfoodservice.module.owner.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Požadavek na potvrzení e-mailového ověření vlastnictví restaurace obsahující IČO a ověřovací kód.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
public class ClaimEmailConfirmRequest {
    @NotBlank
    private String ico;

    @NotBlank
    private String code;
}
