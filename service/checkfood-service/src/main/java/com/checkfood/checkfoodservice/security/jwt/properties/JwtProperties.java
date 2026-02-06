package com.checkfood.checkfoodservice.security.jwt.properties;

import lombok.Getter;
import lombok.Setter;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurace JWT.
 *
 * Hodnoty se načítají z application.yml pod prefixem "security.jwt".
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.jwt")
public class JwtProperties {

    // Secret pro HS256 (min. 32 znaků / 256 bitů)
    private String secret;

    // Platnost access tokenu v sekundách (např. 900 = 15 minut)
    private long accessTokenExpirationSeconds = 900;

    // Platnost refresh tokenu v sekundách (např. 2592000 = 30 dní)
    private long refreshTokenExpirationSeconds = 2_592_000;

    // Issuer
    private String issuer = "checkfood";

}
