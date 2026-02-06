package com.checkfood.checkfoodservice.security.config;

import com.checkfood.checkfoodservice.security.jwt.properties.JwtProperties;

import com.nimbusds.jose.jwk.source.ImmutableSecret;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.*;

import javax.crypto.spec.SecretKeySpec;

import java.nio.charset.StandardCharsets;

/**
 * Kryptografická konfigurace JWT (encoder/decoder).
 */
@Configuration
public class JwtCryptoConfig {

    /**
     * JWT Encoder (HS256).
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
     * JWT Decoder (HS256).
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
