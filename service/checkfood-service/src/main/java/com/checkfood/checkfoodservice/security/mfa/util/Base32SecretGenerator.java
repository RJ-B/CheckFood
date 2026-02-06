package com.checkfood.checkfoodservice.security.mfa.util;

import org.springframework.stereotype.Component;

import java.security.SecureRandom;
import java.util.Base64;

/**
 * Generátor Base32 secretu pro TOTP.
 */
@Component
public class Base32SecretGenerator {

    private static final int SECRET_SIZE = 20; // 160 bit


    private final SecureRandom secureRandom = new SecureRandom();


    /**
     * Vygeneruje nový Base32 secret.
     */
    public String generate() {

        byte[] buffer = new byte[SECRET_SIZE];

        secureRandom.nextBytes(buffer);

        return encodeBase32(buffer);
    }


    /**
     * Zakóduje do Base32 (RFC 4648).
     */
    private String encodeBase32(byte[] data) {

        return Base64.getEncoder().encodeToString(data)
                .replace("=", "")
                .replace("+", "")
                .replace("/", "")
                .substring(0, 32);
    }

}
