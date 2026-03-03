package com.checkfood.checkfoodservice.security.module.oauth.module.apple.properties;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Getter
@Setter
@ConfigurationProperties(prefix = "security.oauth.apple")
public class AppleOAuthProperties {

    @NotBlank(message = "Apple Client ID is required")
    private String clientId;

    private String issuer = "https://appleid.apple.com";

    // Následující jsou potřeba pouze pokud bys dělal i "Sign in with Apple" pro web (code flow)
    // Pro mobilní aplikaci (id_token flow) stačí clientId a issuer.
    private String teamId;
    private String keyId;
    private String privateKey;
}