package com.checkfood.checkfoodservice.security.module.oauth.module.google.properties;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import jakarta.validation.constraints.NotBlank;

/**
 * Konfigurační vlastnosti pro Google OAuth načítané z application.properties
 * pod prefixem security.oauth.google.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.oauth.google")
public class GoogleOAuthProperties {

    @NotBlank(message = "Google Client ID nesmí být prázdné")
    private String clientId;
}