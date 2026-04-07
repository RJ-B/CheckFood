package com.checkfood.checkfoodservice.security.module.oauth.module.apple.dto.response;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

/**
 * DTO odpovědi z Apple JWKS endpointu obsahující seznam veřejných RSA klíčů pro ověření ID tokenů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Getter
@Setter
public class ApplePublicKeyResponse {

    private List<Key> keys;

    /**
     * Jednotlivý RSA veřejný klíč ve formátu JWK (JSON Web Key).
     */
    @Getter
    @Setter
    public static class Key {
        private String kty;
        private String kid;
        private String use;
        private String alg;
        private String n;
        private String e;
    }
}