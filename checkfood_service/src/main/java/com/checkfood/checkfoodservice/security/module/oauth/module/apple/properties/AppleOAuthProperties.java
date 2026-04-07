package com.checkfood.checkfoodservice.security.module.oauth.module.apple.properties;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * Konfigurační vlastnosti pro Apple OAuth modul načítané z application.properties
 * pod prefixem security.oauth.apple.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.oauth.apple")
public class AppleOAuthProperties {

    @NotBlank(message = "Apple Client ID is required")
    private String clientId;

    private String issuer = "https://appleid.apple.com";

    private String teamId;
    private String keyId;
    private String privateKey;
}