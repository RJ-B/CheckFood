package com.checkfood.checkfoodservice.security.module.oauth.module.apple.dto.response;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

/**
 * Odpověď z Apple JWKS endpointu obsahující veřejné klíče.
 */
@Getter
@Setter
public class ApplePublicKeyResponse {
    private List<Key> keys;

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