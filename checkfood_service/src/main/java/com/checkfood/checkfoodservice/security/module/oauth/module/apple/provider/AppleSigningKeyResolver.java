package com.checkfood.checkfoodservice.security.module.oauth.module.apple.provider;

import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthException;
import com.checkfood.checkfoodservice.security.module.oauth.module.apple.client.AppleFeignClient;
import com.checkfood.checkfoodservice.security.module.oauth.module.apple.dto.response.ApplePublicKeyResponse;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.JwsHeader;
import io.jsonwebtoken.Locator;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.math.BigInteger;
import java.security.Key;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.util.Base64;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

/**
 * Resolver veřejných klíčů Apple (JDK 21).
 * Implementuje rozhraní Locator (JJWT 0.12.x) pro dynamické vyhledání klíče podle 'kid'.
 * Obsahuje in-memory caching pro optimalizaci výkonu.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AppleSigningKeyResolver implements Locator<Key> {

    private final AppleFeignClient appleFeignClient;

    private final Map<String, Key> keyCache = new ConcurrentHashMap<>();
    private long lastFetchTime = 0;
    private static final long CACHE_TTL = 24 * 60 * 60 * 1000L; // 24 hodin

    @Override
    public Key locate(Header header) {
        if (!(header instanceof JwsHeader jwsHeader)) {
            throw OAuthException.invalidToken("Token postrádá JWS hlavičku.");
        }

        var kid = jwsHeader.getKeyId();
        if (kid == null) {
            throw OAuthException.invalidToken("V hlavičce Apple tokenu chybí 'kid'.");
        }

        // 1. Zkusíme najít v cache
        if (keyCache.containsKey(kid) && !isCacheExpired()) {
            return keyCache.get(kid);
        }

        // 2. Synchronizované obnovení klíčů
        refreshKeys();

        // 3. Pokus o získání klíče po refreshu
        var key = keyCache.get(kid);
        if (key == null) {
            throw OAuthException.invalidToken("Veřejný klíč Apple (kid: " + kid + ") nebyl nalezen ani po aktualizaci.");
        }

        return key;
    }

    private boolean isCacheExpired() {
        return (System.currentTimeMillis() - lastFetchTime) > CACHE_TTL;
    }

    private synchronized void refreshKeys() {
        // Double-check locking pattern (v rámci synchronized)
        if (!isCacheExpired() && !keyCache.isEmpty()) {
            return;
        }

        log.info("Obnovuji Apple veřejné klíče z API...");
        try {
            var response = appleFeignClient.getApplePublicKeys();

            var newKeys = response.getKeys().stream()
                    .collect(Collectors.toMap(
                            ApplePublicKeyResponse.Key::getKid,
                            this::generatePublicKey
                    ));

            keyCache.clear();
            keyCache.putAll(newKeys);
            lastFetchTime = System.currentTimeMillis();
            log.info("Apple klíče úspěšně obnoveny. Počet klíčů: {}", newKeys.size());

        } catch (OAuthException ex) {
            // Pokud už je to naše výjimka (z generatePublicKey), jen ji pošleme dál
            throw ex;
        } catch (Exception e) {
            // Chyba komunikace - nelogujeme error zde, Handler to udělá
            throw OAuthException.communicationError("APPLE", "Nelze stáhnout veřejné klíče: " + e.getMessage(), e);
        }
    }

    private Key generatePublicKey(ApplePublicKeyResponse.Key key) {
        try {
            var nBytes = Base64.getUrlDecoder().decode(key.getN());
            var eBytes = Base64.getUrlDecoder().decode(key.getE());

            var spec = new RSAPublicKeySpec(
                    new BigInteger(1, nBytes),
                    new BigInteger(1, eBytes)
            );

            return KeyFactory.getInstance("RSA").generatePublic(spec);

        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            // Předáváme 'e' jako cause pro detailní logování v Handleru
            throw OAuthException.internalError("Chyba konverze Apple klíče: " + e.getMessage(), e);
        }
    }
}