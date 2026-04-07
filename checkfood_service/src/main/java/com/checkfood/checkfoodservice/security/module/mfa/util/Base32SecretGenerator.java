package com.checkfood.checkfoodservice.security.module.mfa.util;

import org.springframework.stereotype.Component;

import java.security.SecureRandom;
import java.util.Base64;

/**
 * Generátor kryptograficky bezpečného Base32 tajného klíče pro TOTP autentizaci.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class Base32SecretGenerator {

    private static final int SECRET_SIZE = 20;


    private final SecureRandom secureRandom = new SecureRandom();


    /**
     * Vygeneruje nový kryptograficky bezpečný Base32 tajný klíč délky 160 bitů.
     *
     * @return Base32 řetězec použitelný jako TOTP seed
     */
    public String generate() {

        byte[] buffer = new byte[SECRET_SIZE];

        secureRandom.nextBytes(buffer);

        return encodeBase32(buffer);
    }


    private String encodeBase32(byte[] data) {

        return Base64.getEncoder().encodeToString(data)
                .replace("=", "")
                .replace("+", "")
                .replace("/", "")
                .substring(0, 32);
    }

}
