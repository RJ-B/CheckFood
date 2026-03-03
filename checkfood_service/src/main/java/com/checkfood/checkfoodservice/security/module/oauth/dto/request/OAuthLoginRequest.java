package com.checkfood.checkfoodservice.security.module.oauth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

/**
 * DTO pro požadavek na přihlášení přes OAuth.
 * Sjednoceno s LoginRequest pro konzistentní správu zařízení a JWT relací [cite: 2026-01-24].
 */
@Getter
@Setter
public class OAuthLoginRequest {

    @NotBlank(message = "ID Token nesmí být prázdný")
    private String idToken;

    @NotNull(message = "Poskytovatel musí být určen")
    private AuthProvider provider;

    private String email;

    private String firstName;

    private String lastName;

    // --- Sjednocená sekce pro zařízení (shodná s klasickým loginem) ---

    @NotBlank(message = "Identifikátor zařízení nesmí být prázdný")
    private String deviceIdentifier; // ✅ Změněno z Long deviceId na String deviceIdentifier

    @NotBlank(message = "Název zařízení nesmí být prázdný")
    private String deviceName; // ✅ Přidáno pro sjednocení s Flutter modelem

    @NotBlank(message = "Typ zařízení nesmí být prázdný")
    private String deviceType; // ✅ Přidáno pro sjednocení s Flutter modelem
}