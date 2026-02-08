package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro odhlášení uživatele ze systému.
 * Slouží k invalidaci refresh tokenu a ukončení aktivní relace na konkrétním zařízení.
 *
 * @see AuthService#logout(LogoutRequest)
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LogoutRequest {

    /**
     * Refresh token, který má být invalidován.
     * Token je buď odstraněn z databáze nebo označen jako neplatný.
     */
    @NotBlank(message = "Refresh token nesmí být prázdný.")
    private String refreshToken;

    @NotBlank(message = "Identifikátor zařízení je povinný pro korektní ukončení relace.")
    private String deviceIdentifier;
}