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
 * Resolver veřejných RSA klíčů Apple implementující JJWT rozhraní Locator pro dynamické
 * vyhledání klíče podle identifikátoru 'kid' z JWS hlavičky.
 * Klíče jsou cachovány v paměti s TTL 24 hodin pro optimalizaci výkonu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AppleSigningKeyResolver implements Locator<Key> {

    private final AppleFeignClient appleFeignClient;

    private final Map<String, Key> keyCache = new ConcurrentHashMap<>();
    private long lastFetchTime = 0;
    private static final long CACHE_TTL = 24 * 60 * 60 * 1000L;

    /**
     * Vyhledá veřejný klíč odpovídající identifikátoru 'kid' z JWS hlavičky tokenu.
     *
     * @param header JWS hlavička obsahující identifikátor klíče
     * @return veřejný RSA klíč pro ověření podpisu
     * @throws OAuthException pokud hlavička neobsahuje 'kid' nebo klíč není nalezen
     */
    @Override
    public Key locate(Header header) {
        if (!(header instanceof JwsHeader jwsHeader)) {
            throw OAuthException.invalidToken("Token postrádá JWS hlavičku.");
        }

        var kid = jwsHeader.getKeyId();
        if (kid == null) {
            throw OAuthException.invalidToken("V hlavičce Apple tokenu chybí 'kid'.");
        }

        if (keyCache.containsKey(kid) && !isCacheExpired()) {
            return keyCache.get(kid);
        }

        refreshKeys();

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
        if (!isCacheExpired() && !keyCache.isEmpty()) {
            return;
        }

        log.info("Obnovuji Apple verejne klice z API...");
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
            log.info("Apple klice uspesne obnoveny. Pocet klicu: {}", newKeys.size());

        } catch (OAuthException ex) {
            throw ex;
        } catch (Exception e) {
            throw OAuthException.communicationError("APPLE", "Nelze stahnout verejne klice: " + e.getMessage(), e);
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
            throw OAuthException.internalError("Chyba konverze Apple klice: " + e.getMessage(), e);
        }
    }
}