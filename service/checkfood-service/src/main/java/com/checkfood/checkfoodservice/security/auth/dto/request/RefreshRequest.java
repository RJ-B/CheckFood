package com.checkfood.checkfoodservice.security.auth.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro obnovení Access Tokenu pomocí Refresh Tokenu.
 * Zajišťuje kontinuitu přihlášení bez nutnosti zadávat heslo.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RefreshRequest {

    /**
     * Platný Refresh Token uložený v bezpečném úložišti klienta.
     */
    @NotBlank(message = "Refresh token nesmí být prázdný.")
    private String refreshToken;

    /**
     * Identifikátor zařízení pro validaci vazby tokenu na konkrétní relaci.
     * Nutné pro bezpečnostní kontrolu a prevenci zneužití tokenu na jiném stroji.
     */
    @NotBlank(message = "Identifikátor zařízení je povinný.")
    private String deviceIdentifier;
}