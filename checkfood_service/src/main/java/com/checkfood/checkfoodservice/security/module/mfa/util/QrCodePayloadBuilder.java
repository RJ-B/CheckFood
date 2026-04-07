package com.checkfood.checkfoodservice.security.module.mfa.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Builder pro sestavení otpauth:// URI payloadu určeného ke skenování QR kódem v autentizační aplikaci.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class QrCodePayloadBuilder {

    @Value("${spring.application.name:CheckFood}")
    private String issuer;


    /**
     * Sestaví otpauth:// URI pro skenování QR kódem v autentizační aplikaci.
     *
     * @param email  e-mailová adresa uživatele použitá jako label
     * @param secret Base32 tajný klíč
     * @return otpauth:// URI řetězec
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
