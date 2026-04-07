package com.checkfood.checkfoodservice.security.module.oauth.properties;

import lombok.Getter;
import lombok.Setter;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Sdílené konfigurační vlastnosti pro OAuth modul načítané z application.properties pod prefixem security.oauth.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.oauth")
public class OAuthProperties {

    private boolean enabled = true;

    private String redirectUri;

    private int connectionTimeout = 5000;

    private int readTimeout = 5000;

}
