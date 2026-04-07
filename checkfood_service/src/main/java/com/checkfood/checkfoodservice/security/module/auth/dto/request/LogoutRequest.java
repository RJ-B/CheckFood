package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro odhlášení uživatele ze systému s invalidací refresh tokenu.
 *
 * Zajišťuje bezpečné odhlášení s ukončením relace konkrétního zařízení.
 * Kombinuje invalidaci tokenu s úklidem záznamu zařízení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuthService
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LogoutRequest {

    /**
     * Refresh token pro invalidaci a session cleanup.
     * Token je buď odstraněn z databáze nebo označen jako neplatný.
     */
    @NotBlank(message = "Refresh token nesmí být prázdný.")
    private String refreshToken;

    /**
     * Identifikátor zařízení pro odhlášení konkrétní relace a bezpečnostní sledování.
     * Zajišťuje, že odhlášení ovlivní pouze dané zařízení.
     */
    @NotBlank(message = "Identifikátor zařízení je povinný pro korektní ukončení relace.")
    private String deviceIdentifier;
}