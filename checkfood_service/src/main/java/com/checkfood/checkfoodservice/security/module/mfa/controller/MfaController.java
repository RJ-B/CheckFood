package com.checkfood.checkfoodservice.security.module.mfa.controller;

import com.checkfood.checkfoodservice.security.module.mfa.dto.request.*;
import com.checkfood.checkfoodservice.security.module.mfa.dto.response.*;
import com.checkfood.checkfoodservice.security.module.mfa.dto.request.MfaChallengeVerifyRequest;
import com.checkfood.checkfoodservice.security.module.mfa.dto.request.MfaDisableRequest;
import com.checkfood.checkfoodservice.security.module.mfa.dto.request.MfaSetupVerifyRequest;
import com.checkfood.checkfoodservice.security.module.mfa.dto.response.MfaChallengeResponse;
import com.checkfood.checkfoodservice.security.module.mfa.dto.response.MfaSetupStartResponse;
import com.checkfood.checkfoodservice.security.module.mfa.dto.response.MfaStatusResponse;
import com.checkfood.checkfoodservice.security.module.mfa.service.MfaService;
import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;

import jakarta.validation.Valid;

import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.TimeUnit;

/**
 * REST kontroler pro správu vícefaktorové autentizace (MFA/2FA).
 * Poskytuje endpointy pro nastavení TOTP, ověření přihlašovací výzvy, deaktivaci MFA a zjištění stavu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/mfa")
@RequiredArgsConstructor
public class MfaController {

    private final MfaService mfaService;


    /**
     * Zahájí nastavení MFA pro přihlášeného uživatele a vrátí QR kód a tajný klíč.
     *
     * @param authentication autentizační kontext aktuálního uživatele
     * @return odpověď s QR payloadem a Base32 tajným klíčem
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
     * Potvrdí nastavení MFA zadáním prvního platného TOTP kódu.
     *
     * @param request  požadavek obsahující TOTP kód z autentizační aplikace
     * @param authentication autentizační kontext aktuálního uživatele
     * @return HTTP 200 OK po úspěšném potvrzení
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


    /**
     * Ověří TOTP nebo záložní kód předložený uživatelem při přihlašovací výzvě MFA.
     *
     * @param request  požadavek obsahující kód z autentizační aplikace nebo záložní kód
     * @param authentication autentizační kontext aktuálního uživatele
     * @return odpověď s výsledkem ověření
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


    /**
     * Deaktivuje MFA po ověření aktuálního hesla uživatele.
     *
     * @param request  požadavek obsahující aktuální heslo uživatele
     * @param authentication autentizační kontext aktuálního uživatele
     * @return HTTP 200 OK po úspěšné deaktivaci
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


    /**
     * Vrátí aktuální stav MFA (aktivní/neaktivní) pro přihlášeného uživatele.
     *
     * @param authentication autentizační kontext aktuálního uživatele
     * @return odpověď se stavem MFA
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
