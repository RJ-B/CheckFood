package com.checkfood.checkfoodservice.security.module.mfa.util;

import org.apache.commons.codec.binary.Base32;
import org.springframework.stereotype.Component;

import java.security.SecureRandom;

/**
 * Generátor kryptograficky bezpečného Base32 tajného klíče pro TOTP autentizaci (RFC 6238).
 * <p>
 * Google Authenticator, Authy a ostatní TOTP klienti vyžadují kódování podle RFC 4648
 * (Base32), ne Base64. Starší implementace používala Base64 s manuálním strippováním
 * non-Base32 znaků a {@code substring(0, 32)}, což pro 20bytové vstupy generovalo
 * řetězce délky 27–28 a volání substring házelo {@link StringIndexOutOfBoundsException}
 * (→ HTTP 500 na všech MFA endpointech).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
public class Base32SecretGenerator {

    /**
     * Délka seedu v bytech. 20 B = 160 bitů je doporučená minimální velikost
     * pro HMAC-SHA1 TOTP (viz RFC 4226 §4).
     */
    private static final int SECRET_SIZE = 20;

    private final SecureRandom secureRandom = new SecureRandom();
    private final Base32 base32 = new Base32();

    /**
     * Vygeneruje nový kryptograficky bezpečný Base32 tajný klíč délky 160 bitů.
     * Výsledkem je 32znakový řetězec bez paddingu (20 B → 32 Base32 znaků + 0× {@code =}
     * po stripnutí). Znaky jsou z abecedy A–Z, 2–7 podle RFC 4648 §6.
     *
     * @return Base32 řetězec použitelný jako TOTP seed pro otpauth:// URI
     */
    public String generate() {
        byte[] buffer = new byte[SECRET_SIZE];
        secureRandom.nextBytes(buffer);
        // Strip padding '=' — Google Authenticator akceptuje s i bez paddingu,
        // ale většina QR generátorů preferuje bez.
        return base32.encodeAsString(buffer).replace("=", "");
    }
}
