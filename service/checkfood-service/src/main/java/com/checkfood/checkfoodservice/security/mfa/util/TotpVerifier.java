package com.checkfood.checkfoodservice.security.mfa.util;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Component;

import java.time.Instant;

/**
 * Ověřovač TOTP kódů.
 */
@Component
@RequiredArgsConstructor
public class TotpVerifier {

    private static final int TIME_STEP_SECONDS = 30;

    // Povolený drift: ±1 okno (30s dozadu/dopředu)
    private static final int WINDOW = 1;

    private final TotpGenerator totpGenerator;


    /**
     * Ověří TOTP kód.
     */
    public boolean verify(String secret, String code) {

        long currentCounter =
                Instant.now().getEpochSecond() / TIME_STEP_SECONDS;

        // Zkus minulý, aktuální i budoucí interval
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
