package com.checkfood.checkfoodservice.security.config;

import com.checkfood.checkfoodservice.security.module.jwt.properties.JwtProperties;

import com.nimbusds.jose.jwk.source.ImmutableSecret;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.*;

import javax.crypto.spec.SecretKeySpec;

import java.nio.charset.StandardCharsets;

/**
 * Konfigurace kryptografických komponent pro JWT tokeny.
 * Poskytuje encoder a decoder beany používající HMAC SHA-256 algoritmus.
 * Secret key je načítán z JwtProperties konfigurace.
 *
 * @see JwtProperties
 */
@Configuration
public class JwtCryptoConfig {

    /**
     * Vytvoří JWT encoder pro podepisování tokenů pomocí HS256 algoritmu.
     * Používá symetrický secret key z konfigurace.
     *
     * @param properties JWT konfigurace obsahující secret key
     * @return nakonfigurovaný JWT encoder
     */
    @Bean
    public JwtEncoder jwtEncoder(JwtProperties properties) {

        byte[] keyBytes =
                properties.getSecret()
                        .getBytes(StandardCharsets.UTF_8);

        SecretKeySpec secretKey =
                new SecretKeySpec(
                        keyBytes,
                        "HmacSHA256"
                );

        return new NimbusJwtEncoder(
                new ImmutableSecret<>(secretKey)
        );
    }

    /**
     * Vytvoří JWT decoder pro validaci a parsování tokenů pomocí HS256 algoritmu.
     * Používá stejný symetrický secret key jako encoder.
     *
     * @param properties JWT konfigurace obsahující secret key
     * @return nakonfigurovaný JWT decoder
     */
    @Bean
    public JwtDecoder jwtDecoder(JwtProperties properties) {

        byte[] keyBytes =
                properties.getSecret()
                        .getBytes(StandardCharsets.UTF_8);

        SecretKeySpec secretKey =
                new SecretKeySpec(
                        keyBytes,
                        "HmacSHA256"
                );

        return NimbusJwtDecoder
                .withSecretKey(secretKey)
                .macAlgorithm(MacAlgorithm.HS256)
                .build();
    }
}