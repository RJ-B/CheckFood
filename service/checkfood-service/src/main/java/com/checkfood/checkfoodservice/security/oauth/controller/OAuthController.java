package com.checkfood.checkfoodservice.security.oauth.controller;

import com.checkfood.checkfoodservice.security.auth.dto.response.AuthResponse;
import com.checkfood.checkfoodservice.security.oauth.dto.request.OAuthLoginRequest;
import com.checkfood.checkfoodservice.security.oauth.service.OAuthService;
import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;

import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.TimeUnit;

/**
 * Controller pro OAuth přihlašování (Google / Apple).
 */
@RestController
@RequestMapping("/api/oauth")
@RequiredArgsConstructor
public class OAuthController {

    private final OAuthService oAuthService;


    /**
     * OAuth login endpoint.
     *
     * Flutter pošle ID token + provider,
     * backend vrátí vlastní JWT.
     */
    @RateLimited(
            key = "oauth:login",
            limit = 5,
            duration = 1,
            unit = TimeUnit.MINUTES,
            perIp = true
    )
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(
            @Valid @RequestBody OAuthLoginRequest request
    ) {

        AuthResponse response =
                oAuthService.login(request);

        return ResponseEntity.ok(response);
    }

}
