package com.checkfood.checkfoodservice.security.module.oauth.controller;

import com.checkfood.checkfoodservice.security.module.auth.dto.response.AuthResponse;
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
 * REST kontroler pro OAuth přihlašování přes externí poskytovatele identity (Google, Apple).
 * Vrací sjednocený formát AuthResponse kompatibilní s ostatními autentizačními endpointy.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/oauth")
@RequiredArgsConstructor
public class OAuthController {

    private final OAuthService oAuthService;

    /**
     * Provede OAuth přihlášení uživatele ověřením ID tokenu od poskytovatele.
     *
     * @param request požadavek obsahující ID token, typ poskytovatele a data o zařízení
     * @return odpověď s JWT tokeny a daty uživatele
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
        AuthResponse response = oAuthService.login(request);
        return ResponseEntity.ok(response);
    }
}