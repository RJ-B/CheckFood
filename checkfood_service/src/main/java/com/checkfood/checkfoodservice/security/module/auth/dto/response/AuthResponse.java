package com.checkfood.checkfoodservice.security.module.auth.dto.response;

import com.checkfood.checkfoodservice.security.module.user.dto.response.UserResponse;
import lombok.*;

/**
 * Response DTO pro úspěšnou autentizaci obsahující JWT tokeny a profil uživatele.
 *
 * Úplná autentizační odpověď kombinující session tokeny s informacemi o uživateli
 * pro inicializaci stavu klienta po úspěšném přihlášení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserResponse
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuthResponse {

    /**
     * JWT access token pro autorizaci API.
     * Krátkodobý token používaný v hlavičce Authorization ve formátu "Bearer {token}".
     */
    private String accessToken;

    /**
     * Refresh token pro obnovu access tokenu.
     * Dlouhodobý token pro plynulé prodloužení session bez opětovné autentizace.
     */
    private String refreshToken;

    /**
     * Typ tokenu pro formátování hlavičky Authorization.
     */
    @Builder.Default
    private String tokenType = "Bearer";

    /**
     * Čas platnosti access tokenu v sekundách pro logiku obnovy na straně klienta.
     */
    private Long expiresIn;

    /**
     * Úplné profilové informace uživatele pro inicializaci stavu klienta.
     */
    private UserResponse user;
}