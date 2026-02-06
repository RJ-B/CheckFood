package com.checkfood.checkfoodservice.security.oauth.properties;

import lombok.Getter;
import lombok.Setter;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Společná konfigurace pro OAuth modul.
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.oauth")
public class OAuthProperties {

    // Povolení OAuth přihlašování
    private boolean enabled = true;

    // Redirect URI (pokud používáš authorization code flow)
    private String redirectUri;

    // Timeout pro komunikaci s providerem (ms)
    private int connectionTimeout = 5000;

    // Read timeout (ms)
    private int readTimeout = 5000;

}
