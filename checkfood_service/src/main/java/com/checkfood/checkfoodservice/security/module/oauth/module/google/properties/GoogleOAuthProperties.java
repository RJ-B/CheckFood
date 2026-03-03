package com.checkfood.checkfoodservice.security.module.oauth.module.google.properties;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration; // ✅ Přidáno
import jakarta.validation.constraints.NotBlank;

/**
 * Konfigurační vlastnosti pro Google OAuth.
 * Načítá hodnoty z application.yml pod prefixem security.oauth.google.
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.oauth.google")
public class GoogleOAuthProperties {

    /**
     * Google Client ID (Web Client ID z Google Cloud Console).
     * Slouží k ověření 'aud' claimu v ID tokenu.
     */
    @NotBlank(message = "Google Client ID nesmí být prázdné")
    private String clientId;
}