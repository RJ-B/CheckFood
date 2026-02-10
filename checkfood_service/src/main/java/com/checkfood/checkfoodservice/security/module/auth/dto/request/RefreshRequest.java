package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro obnovení access tokenu pomocí refresh tokenu.
 * Umožňuje uživateli zůstat přihlášený bez nutnosti opakovaného zadávání přihlašovacích údajů.
 *
 * @see AuthService#refreshToken(RefreshRequest)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RefreshRequest {

    /**
     * Platný refresh token uložený v bezpečném úložišti klienta.
     * Používá se k vygenerování nového páru access a refresh tokenů.
     */
    @NotBlank(message = "Refresh token nesmí být prázdný.")
    private String refreshToken;

    /**
     * Jedinečný identifikátor zařízení pro validaci vazby tokenu na konkrétní relaci.
     * Zajišťuje, že token může být použit pouze na zařízení, pro které byl vydán.
     */
    @NotBlank(message = "Identifikátor zařízení je povinný.")
    private String deviceIdentifier;
}