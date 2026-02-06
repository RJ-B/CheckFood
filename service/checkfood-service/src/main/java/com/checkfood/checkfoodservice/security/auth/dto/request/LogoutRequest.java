package com.checkfood.checkfoodservice.security.auth.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro bezpečné odhlášení uživatele.
 * Slouží k invalidaci refresh tokenu a korektnímu ukončení relace konkrétního zařízení.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LogoutRequest {

    /**
     * Refresh token, který má být zneplatněn v databázi/whitelistu.
     */
    @NotBlank(message = "Refresh token nesmí být prázdný.")
    private String refreshToken;

    /**
     * Identifikátor zařízení, ze kterého se uživatel odhlašuje.
     * Umožňuje DeviceService odstranit konkrétní záznam z aktivních relací.
     */
    @NotBlank(message = "Identifikátor zařízení je povinný pro korektní ukončení relace.")
    private String deviceIdentifier;
}