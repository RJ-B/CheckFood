package com.checkfood.checkfoodservice.security.mfa.util;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Component;

import java.nio.ByteBuffer;
import java.security.GeneralSecurityException;
import java.time.Instant;

/**
 * Generátor TOTP kódů (RFC 6238).
 */
@Component
public class TotpGenerator {

    private static final String HMAC_ALGORITHM = "HmacSHA1";

    private static final int TIME_STEP_SECONDS = 30;

    private static final int DIGITS = 6;


    /**
     * Vygeneruje TOTP kód pro daný čas.
     */
    public String generate(String base32Secret) {

        long counter =
                Instant.now().getEpochSecond() / TIME_STEP_SECONDS;

        return generateForCounter(base32Secret, counter);
    }


    public String generateForCounter(String secret, long counter) {

        try {

            byte[] key = decodeSecret(secret);

            byte[] data =
                    ByteBuffer.allocate(8).putLong(counter).array();

            Mac mac = Mac.getInstance(HMAC_ALGORITHM);

            mac.init(new SecretKeySpec(key, HMAC_ALGORITHM));

            byte[] hash = mac.doFinal(data);

            int offset = hash[hash.length - 1] & 0xF;

            int binary =
                    ((hash[offset] & 0x7f) << 24)
                            | ((hash[offset + 1] & 0xff) << 16)
                            | ((hash[offset + 2] & 0xff) << 8)
                            | (hash[offset + 3] & 0xff);

            int otp = binary % (int) Math.pow(10, DIGITS);

            return String.format("%0" + DIGITS + "d", otp);

        } catch (GeneralSecurityException ex) {

            throw new IllegalStateException(
                    "Failed to generate TOTP code",
                    ex
            );
        }
    }


    /**
     * Dekóduje Base32 secret.
     */
    private byte[] decodeSecret(String secret) {

        return java.util.Base64.getDecoder().decode(secret);
    }

}
