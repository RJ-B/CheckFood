package com.checkfood.checkfoodservice.module.owner.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Požadavek na zahájení e-mailového ověření vlastnictví restaurace podle IČO.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@NoArgsConstructor
public class ClaimEmailStartRequest {
    @NotBlank
    private String ico;
}
