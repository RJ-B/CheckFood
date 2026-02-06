package com.checkfood.checkfoodservice.security.mfa.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Builder pro QR payload (otpauth://).
 */
@Component
public class QrCodePayloadBuilder {

    @Value("${spring.application.name:CheckFood}")
    private String issuer;


    /**
     * Vytvoří payload pro QR kód.
     */
    public String build(String email, String secret) {

        try {

            String encodedIssuer =
                    URLEncoder.encode(issuer, StandardCharsets.UTF_8);

            String encodedEmail =
                    URLEncoder.encode(email, StandardCharsets.UTF_8);

            return String.format(
                    "otpauth://totp/%s:%s?secret=%s&issuer=%s",
                    encodedIssuer,
                    encodedEmail,
                    secret,
                    encodedIssuer
            );

        } catch (Exception ex) {

            throw new IllegalStateException(
                    "Failed to build QR payload",
                    ex
            );
        }
    }

}
