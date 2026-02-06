package com.checkfood.checkfoodservice.security.oauth.dto.request;

import com.checkfood.checkfoodservice.security.oauth.provider.OAuthProviderType;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Request pro OAuth přihlášení.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OAuthLoginRequest {

    // Typ OAuth providera (GOOGLE / APPLE)
    @NotNull(message = "Provider type is required")
    private OAuthProviderType providerType;

    // ID token získaný z Google / Apple
    @NotBlank(message = "ID token must not be empty")
    private String idToken;

}
