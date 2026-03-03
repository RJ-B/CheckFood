package com.checkfood.checkfoodservice.security.module.oauth.module.apple.client;

import com.checkfood.checkfoodservice.security.module.oauth.module.apple.dto.response.ApplePublicKeyResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "apple-auth-client", url = "https://appleid.apple.com/auth")
public interface AppleFeignClient {

    @GetMapping("/keys")
    ApplePublicKeyResponse getApplePublicKeys();
}