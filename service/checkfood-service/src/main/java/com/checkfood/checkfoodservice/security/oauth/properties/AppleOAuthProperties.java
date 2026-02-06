package com.checkfood.checkfoodservice.security.oauth.properties;

import lombok.Getter;
import lombok.Setter;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurace pro Apple Sign-In.
 *
 * Načítá se z properties pod prefixem: security.oauth.apple
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.oauth.apple")
public class AppleOAuthProperties {

    // Services ID / Client ID pro Apple (např. com.checkfood.service)
    private String clientId;

    // Apple issuer (default)
    private String issuer = "https://appleid.apple.com";

    // Team ID (pro code flow / token exchange)
    private String teamId;

    // Key ID (pro podepisování client_secret JWT)
    private String keyId;

    // Private key (PEM) - pro code flow / token exchange
    // Pozor: ukládat pouze přes ENV, nikdy do Gitu
    private String privateKey;

}
