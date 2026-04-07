package com.checkfood.checkfoodservice.security.module.oauth.module.apple.client;

import com.checkfood.checkfoodservice.security.module.oauth.module.apple.dto.response.ApplePublicKeyResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Feign klient pro komunikaci s Apple JWKS endpointem pro stahování veřejných klíčů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@FeignClient(name = "apple-auth-client", url = "https://appleid.apple.com/auth")
public interface AppleFeignClient {

    /**
     * Stáhne aktuální sadu veřejných klíčů Apple pro ověřování podpisů ID tokenů.
     *
     * @return odpověď s veřejnými klíči ve formátu JWK
     */
    @GetMapping("/keys")
    ApplePublicKeyResponse getApplePublicKeys();
}