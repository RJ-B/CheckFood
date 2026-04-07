package com.checkfood.checkfoodservice.security.module.mfa.util;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;

import java.time.Instant;

/**
 * Ověřovač TOTP kódů s tolerancí na časový posun (clock skew) v rozsahu ±1 časového okna (30 s).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Component
@RequiredArgsConstructor
public class TotpVerifier {

    private static final int TIME_STEP_SECONDS = 30;

    private static final int WINDOW = 1;

    private final TotpGenerator totpGenerator;


    /**
     * Ověří TOTP kód vůči tajnému klíči s tolerancí na časový posun.
     *
     * @param secret Base32 tajný klíč
     * @param code   šestimístný TOTP kód zadaný uživatelem
     * @return true pokud kód odpovídá aktuálnímu nebo sousednímu časovému oknu
     */
    public boolean verify(String secret, String code) {

        long currentCounter =
                Instant.now().getEpochSecond() / TIME_STEP_SECONDS;

        for (int i = -WINDOW; i <= WINDOW; i++) {

            String expected =
                    totpGenerator.generateForCounter(
                            secret,
                            currentCounter + i
                    );

            if (expected.equals(code)) {
                return true;
            }
        }

        return false;
    }

}
