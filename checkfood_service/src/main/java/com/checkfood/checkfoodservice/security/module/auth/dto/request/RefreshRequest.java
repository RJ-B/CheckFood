package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro obnovení access tokenu pomocí refresh tokenu.
 *
 * Implementuje workflow obnovy tokenu pro plynulý uživatelský zážitek
 * bez nutnosti opětovné autentizace. Zahrnuje ověření vazby tokenu na zařízení
 * jako ochranu před krádeží tokenu.
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
public class RefreshRequest {

    /**
     * Platný refresh token z bezpečného úložiště klienta.
     * Používá se pro generování nového páru tokenů s prodlouženou platností.
     */
    @NotBlank(message = "Refresh token nesmí být prázdný.")
    private String refreshToken;

    /**
     * Identifikátor zařízení pro ověření vazby tokenu na zařízení.
     * Bezpečnostní opatření zajišťující, že token lze použít pouze na původním zařízení.
     */
    @NotBlank(message = "Identifikátor zařízení je povinný.")
    private String deviceIdentifier;
}