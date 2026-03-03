package com.checkfood.checkfoodservice.security.module.auth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.service.AuthService;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * DTO pro obnovení access tokenu pomocí refresh tokenu.
 *
 * Implementuje token refresh workflow pro seamless user experience
 * bez nutnosti re-authentication. Zahrnuje device binding validation
 * pro security protection proti token theft.
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
     * Platný refresh token ze secure client storage.
     * Používá se pro generování nového token pair s extended expiration.
     */
    @NotBlank(message = "Refresh token nesmí být prázdný.")
    private String refreshToken;

    /**
     * Device identifier pro token-device binding validation.
     * Security measure zajišťující že token lze použít pouze na původním zařízení.
     */
    @NotBlank(message = "Identifikátor zařízení je povinný.")
    private String deviceIdentifier;
}