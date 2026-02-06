package com.checkfood.checkfoodservice.security.oauth.properties;

import lombok.Getter;
import lombok.Setter;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurace pro Google OAuth.
 *
 * Načítá se z properties pod prefixem: security.oauth.google
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.oauth.google")
public class GoogleOAuthProperties {

    // Client ID z Google Console
    private String clientId;

    // Client Secret (pokud používáš code flow)
    private String clientSecret;

    // Issuer (default Google)
    private String issuer = "https://accounts.google.com";

}
