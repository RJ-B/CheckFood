package com.checkfood.checkfoodservice.security.module.oauth.controller;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse; // ✅ Import ze sdíleného modulu
import com.checkfood.checkfoodservice.security.module.oauth.dto.request.OAuthLoginRequest;
import com.checkfood.checkfoodservice.security.module.oauth.service.OAuthService;
import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.TimeUnit;

/**
 * Controller pro OAuth přihlašování.
 * Zajišťuje sjednocený výstupní formát pro všechny typy autentizace.
 */
@RestController
@RequestMapping("/api/oauth")
@RequiredArgsConstructor
public class OAuthController {

    private final OAuthService oAuthService;

    /**
     * OAuth login endpoint.
     * ✅ Vrací sjednocený AuthResponse pro bezproblémové parsování na frontendu.
     */
    @RateLimited(
            key = "oauth:login",
            limit = 5,
            duration = 1,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody OAuthLoginRequest request) {
        // OAuthService nyní vrací standardní AuthResponse
        AuthResponse response = oAuthService.login(request);
        return ResponseEntity.ok(response);
    }
}