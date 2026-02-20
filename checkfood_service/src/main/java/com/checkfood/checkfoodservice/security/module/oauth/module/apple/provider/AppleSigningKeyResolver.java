package com.checkfood.checkfoodservice.security.module.oauth.provider.apple;

import com.checkfood.checkfoodservice.security.module.oauth.dto.response.ApplePublicKeyResponse;
import com.checkfood.checkfoodservice.security.module.oauth.exception.OAuthTokenInvalidException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwsHeader;
import io.jsonwebtoken.SigningKeyResolverAdapter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.math.BigInteger;
import java.security.Key;
import java.security.KeyFactory;
import java.security.spec.RSAPublicKeySpec;
import java.util.Base64;

/**
 * Logika pro dynamické vyhledání a rekonstrukci veřejného klíče Apple.
 * Implementuje adaptér knihovny JJWT pro validaci podpisu JWT.
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AppleSigningKeyResolver extends SigningKeyResolverAdapter {

    private final AppleFeignClient appleFeignClient;

    @Override
    public Key resolveSigningKey(JwsHeader header, Claims claims) {
        String kid = header.getKeyId();
        if (kid == null) {
            throw new OAuthTokenInvalidException("Apple ID Token neobsahuje 'kid' v hlavičce.");
        }

        // 1. Stažení aktuálních klíčů z Apple serveru
        // Doporučení: V produkci zde použijte Spring Cache (@Cacheable), aby se klíče nestahovaly při každém volání.
        ApplePublicKeyResponse response = appleFeignClient.getApplePublicKeys();

        // 2. Vyhledání klíče podle ID (kid)
        ApplePublicKeyResponse.Key appleKey = response.getKeys().stream()
                .filter(k -> k.getKid().equals(kid))
                .findFirst()
                .orElseThrow(() -> new OAuthTokenInvalidException("Veřejný klíč s kid " + kid + " nebyl nalezen."));

        // 3. Rekonstrukce RSA veřejného klíče
        return generatePublicKey(appleKey);
    }

    /**
     * Převede parametry klíče (modulus a exponent) na objekt RSAPublicKey.
     */
    private Key generatePublicKey(ApplePublicKeyResponse.Key key) {
        try {
            byte[] nBytes = Base64.getUrlDecoder().decode(key.getN());
            byte[] eBytes = Base64.getUrlDecoder().decode(key.getE());

            BigInteger n = new BigInteger(1, nBytes);
            BigInteger e = new BigInteger(1, eBytes);

            RSAPublicKeySpec publicKeySpec = new RSAPublicKeySpec(n, e);
            KeyFactory keyFactory = KeyFactory.getInstance(key.getKty()); // Typicky "RSA"

            return keyFactory.generatePublic(publicKeySpec);
        } catch (Exception ex) {
            log.error("Chyba při generování veřejného klíče Apple: {}", ex.getMessage());
            throw new OAuthTokenInvalidException("Nepodařilo se zrekonstruovat veřejný klíč pro ověření podpisu.");
        }
    }
}