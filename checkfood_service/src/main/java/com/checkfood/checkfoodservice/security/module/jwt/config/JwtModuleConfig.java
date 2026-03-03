package com.checkfood.checkfoodservice.security.module.jwt.config;

import com.checkfood.checkfoodservice.security.module.jwt.properties.JwtProperties;
import com.nimbusds.jose.jwk.source.ImmutableSecret;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtEncoder;

import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;

/**
 * Centrální konfigurace JWT modulu.
 * Zodpovídá za aktivaci vlastností a vytvoření kryptografických komponent.
 */
@Configuration
@ConfigurationPropertiesScan(basePackages = "com.checkfood.checkfoodservice.security.module.jwt")
public class JwtModuleConfig {

    /**
     * Vytvoří encoder pro podepisování tokenů.
     */
    @Bean
    public JwtEncoder jwtEncoder(JwtProperties properties) {
        SecretKeySpec secretKey = new SecretKeySpec(
                properties.getSecret().getBytes(StandardCharsets.UTF_8),
                "HmacSHA256"
        );
        return new NimbusJwtEncoder(new ImmutableSecret<>(secretKey));
    }

    /**
     * Vytvoří decoder pro validaci tokenů.
     */
    @Bean
    public JwtDecoder jwtDecoder(JwtProperties properties) {
        SecretKeySpec secretKey = new SecretKeySpec(
                properties.getSecret().getBytes(StandardCharsets.UTF_8),
                "HmacSHA256"
        );
        return NimbusJwtDecoder.withSecretKey(secretKey)
                .macAlgorithm(MacAlgorithm.HS256)
                .build();
    }
}