package com.checkfood.checkfoodservice.security.oauth.dto.request;

import com.checkfood.checkfoodservice.security.oauth.provider.OAuthProviderType;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Request pro výměnu authorization code za OAuth token.
 *
 * Používá se při authorization code flow.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OAuthTokenExchangeRequest {

    // Typ providera (GOOGLE / APPLE)
    @NotNull(message = "Provider type is required")
    private OAuthProviderType providerType;

    // Authorization code z OAuth redirectu
    @NotBlank(message = "Authorization code is required")
    private String authorizationCode;

    // Redirect URI použitá při loginu
    @NotBlank(message = "Redirect URI is required")
    private String redirectUri;

}
