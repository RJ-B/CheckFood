package com.checkfood.checkfoodservice.security.module.jwt.properties;

import lombok.Getter;
import lombok.Setter;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurační properties pro JWT modul.
 * Načítá hodnoty z application.properties s prefixem {@code security.jwt}
 * a definuje parametry pro generování a validaci JWT tokenů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.jwt")
public class JwtProperties {

    /**
     * Secret klíč pro HS256 podpis tokenů.
     * Minimální délka: 32 znaků (256 bitů).
     * Načítá se z {@code ${JWT_SECRET}} v application.properties.
     */
    private String secret;

    /**
     * Doba platnosti access tokenu v sekundách.
     * Výchozí: 900 sekund (15 minut).
     * Načítá se z {@code ${JWT_EXPIRES:3600}} v application.properties.
     */
    private long accessTokenExpirationSeconds = 900;

    /**
     * Doba platnosti refresh tokenu v sekundách.
     * Výchozí: 2592000 sekund (30 dní).
     * Načítá se z {@code ${JWT_REFRESH:86400}} v application.properties.
     */
    private long refreshTokenExpirationSeconds = 2_592_000;

    /**
     * Identifikátor vydavatele tokenu (issuer claim).
     * Výchozí: "checkfood".
     * Načítá se z {@code ${JWT_ISSUER:checkfood-api}} v application.properties.
     */
    private String issuer = "checkfood";
}