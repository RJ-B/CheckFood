package com.checkfood.checkfoodservice.security.mfa.controller;

import com.checkfood.checkfoodservice.security.mfa.dto.request.*;
import com.checkfood.checkfoodservice.security.mfa.dto.response.*;
import com.checkfood.checkfoodservice.security.mfa.service.MfaService;
import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;
import com.checkfood.checkfoodservice.security.user.entity.UserEntity;

import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.TimeUnit;

/**
 * REST API pro MFA (2FA).
 */
@RestController
@RequestMapping("/api/mfa")
@RequiredArgsConstructor
public class MfaController {

    private final MfaService mfaService;


    // =====================================================
    // SETUP
    // =====================================================

    /**
     * Zahájí nastavení MFA (vygeneruje QR).
     */
    @RateLimited(
            key = "mfa:setup:start",
            limit = 3,
            duration = 30,
            unit = TimeUnit.MINUTES,
            perUser = true,
            perIp = true
    )
    @PostMapping("/setup/start")
    public ResponseEntity<MfaSetupStartResponse> startSetup(
            Authentication authentication
    ) {

        UserEntity user =
                (UserEntity) authentication.getPrincipal();

        MfaSetupStartResponse response =
                mfaService.startSetup(user.getId());

        return ResponseEntity.ok(response);
    }


    /**
     * Potvrdí MFA nastavení.
     */
    @RateLimited(
            key = "mfa:setup:verify",
            limit = 5,
            duration = 10,
            unit = TimeUnit.MINUTES,
            perUser = true,
            perIp = true
    )
    @PostMapping("/setup/verify")
    public ResponseEntity<Void> verifySetup(
            @Valid @RequestBody MfaSetupVerifyRequest request,
            Authentication authentication
    ) {

        UserEntity user =
                (UserEntity) authentication.getPrincipal();

        mfaService.verifySetup(
                user.getId(),
                request.getCode()
        );

        return ResponseEntity.ok().build();
    }


    // =====================================================
    // LOGIN CHALLENGE
    // =====================================================

    /**
     * Ověří MFA kód při přihlášení.
     */
    @RateLimited(
            key = "mfa:challenge:verify",
            limit = 3,
            duration = 5,
            unit = TimeUnit.MINUTES,
            perUser = true,
            perIp = true
    )
    @PostMapping("/challenge/verify")
    public ResponseEntity<MfaChallengeResponse> verifyChallenge(
            @Valid @RequestBody MfaChallengeVerifyRequest request,
            Authentication authentication
    ) {

        UserEntity user =
                (UserEntity) authentication.getPrincipal();

        MfaChallengeResponse response =
                mfaService.verifyChallenge(
                        user.getId(),
                        request.getCode()
                );

        return ResponseEntity.ok(response);
    }


    // =====================================================
    // DISABLE
    // =====================================================

    /**
     * Vypne MFA.
     */
    @RateLimited(
            key = "mfa:disable",
            limit = 3,
            duration = 10,
            unit = TimeUnit.MINUTES,
            perUser = true,
            perIp = true
    )
    @PostMapping("/disable")
    public ResponseEntity<Void> disable(
            @Valid @RequestBody MfaDisableRequest request,
            Authentication authentication
    ) {

        UserEntity user =
                (UserEntity) authentication.getPrincipal();

        mfaService.disable(
                user.getId(),
                request.getPassword()
        );

        return ResponseEntity.ok().build();
    }


    // =====================================================
    // STATUS
    // =====================================================

    /**
     * Vrátí stav MFA.
     */
    @RateLimited(
            key = "mfa:status",
            limit = 30,
            duration = 1,
            unit = TimeUnit.MINUTES,
            perUser = true
    )
    @GetMapping("/status")
    public ResponseEntity<MfaStatusResponse> status(
            Authentication authentication
    ) {

        UserEntity user =
                (UserEntity) authentication.getPrincipal();

        MfaStatusResponse response =
                mfaService.getStatus(user.getId());

        return ResponseEntity.ok(response);
    }

}
