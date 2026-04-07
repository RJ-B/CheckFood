package com.checkfood.checkfoodservice.security.module.oauth.dto.request;

import com.checkfood.checkfoodservice.security.module.auth.provider.AuthProvider;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

/**
 * DTO pro požadavek na OAuth přihlášení obsahující ID token providera a data o zařízení.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
public class OAuthLoginRequest {

    @NotBlank(message = "ID Token nesmí být prázdný")
    private String idToken;

    @NotNull(message = "Provider musí být určen")
    private AuthProvider provider;

    private String email;

    private String firstName;

    private String lastName;

    @NotBlank(message = "Identifikátor zařízení nesmí být prázdný")
    private String deviceIdentifier;

    @NotBlank(message = "Název zařízení nesmí být prázdný")
    private String deviceName;

    @NotBlank(message = "Typ zařízení nesmí být prázdný")
    private String deviceType;
}