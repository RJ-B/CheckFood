package com.checkfood.checkfoodservice.module.owner.controller;

import com.checkfood.checkfoodservice.module.owner.dto.*;
import com.checkfood.checkfoodservice.module.owner.service.OwnerClaimService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/owner/claim")
@RequiredArgsConstructor
public class OwnerClaimController {

    private final OwnerClaimService ownerClaimService;

    @PostMapping("/ares")
    public ResponseEntity<AresLookupResponse> lookupAres(
            @Valid @RequestBody ClaimAresRequest request,
            Authentication auth) {
        Long userId = extractUserId(auth);
        return ResponseEntity.ok(ownerClaimService.lookupAres(request.getIco(), userId));
    }

    @PostMapping("/bankid")
    public ResponseEntity<ClaimResultResponse> verifyBankId(
            @Valid @RequestBody ClaimBankIdRequest request,
            Authentication auth) {
        Long userId = extractUserId(auth);
        return ResponseEntity.ok(ownerClaimService.verifyBankId(request.getIco(), userId));
    }

    @PostMapping("/email/start")
    public ResponseEntity<ClaimResultResponse> startEmailClaim(
            @Valid @RequestBody ClaimEmailStartRequest request,
            Authentication auth) {
        Long userId = extractUserId(auth);
        return ResponseEntity.ok(ownerClaimService.startEmailClaim(request.getIco(), userId));
    }

    @PostMapping("/email/confirm")
    public ResponseEntity<ClaimResultResponse> confirmEmailClaim(
            @Valid @RequestBody ClaimEmailConfirmRequest request,
            Authentication auth) {
        Long userId = extractUserId(auth);
        return ResponseEntity.ok(ownerClaimService.confirmEmailClaim(request.getIco(), request.getCode(), userId));
    }

    private Long extractUserId(Authentication auth) {
        var user = (UserEntity) auth.getPrincipal();
        return user.getId();
    }
}
