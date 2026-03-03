package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro odhlášení uživatele ze systému s invalidací refresh tokenu.
 *
 * Zajišťuje secure logout process s device-specific session termination.
 * Kombinuje token invalidation s device tracking cleanup.
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
     * Device identifier pro device-specific logout a security tracking.
     * Zajišťuje že logout ovlivní pouze konkrétní zařízení.
     */
    @NotBlank(message = "Identifikátor zařízení je povinný pro korektní ukončení relace.")
    private String deviceIdentifier;
}