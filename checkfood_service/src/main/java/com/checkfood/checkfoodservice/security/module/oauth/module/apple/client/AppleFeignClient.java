package com.checkfood.checkfoodservice.security.module.oauth.provider.apple;

import com.checkfood.checkfoodservice.security.module.oauth.dto.response.ApplePublicKeyResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Deklarativní REST klient pro komunikaci s Apple Auth servery.
 * Zodpovídá za stahování veřejných klíčů (JWKS) pro verifikaci podpisů.
 */
@FeignClient(name = "apple-auth-client", url = "https://appleid.apple.com/auth")
public interface AppleFeignClient {

    /**
     * Načte aktuální sadu veřejných klíčů přímo z oficiálního endpointu Apple.
     * Apple tyto klíče pravidelně obměňuje (key rotation).
     *
     * @return Objekt obsahující seznam aktuálně platných veřejných klíčů.
     */
    @GetMapping("/keys")
    ApplePublicKeyResponse getApplePublicKeys();
}