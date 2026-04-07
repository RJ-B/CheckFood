package com.checkfood.checkfoodservice.module.owner.controller;

import com.checkfood.checkfoodservice.module.owner.dto.*;
import com.checkfood.checkfoodservice.module.owner.service.OwnerClaimService;
import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

/**
 * REST kontroler pro správu procesu přiřazení restaurace majiteli (owner claim flow).
 * Poskytuje endpointy pro ověření přes ARES, BankID a e-mail.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/owner/claim")
@RequiredArgsConstructor
public class OwnerClaimController {

    private final OwnerClaimService ownerClaimService;

    /**
     * Vyhledá firmu v ARES podle IČO a vrátí informace o přidružené restauraci.
     *
     * @param request požadavek obsahující IČO
     * @param auth    autentizační kontext přihlášeného uživatele
     * @return informace o firmě a restauraci z ARES
     */
    @PostMapping("/ares")
    public ResponseEntity<AresLookupResponse> lookupAres(
            @Valid @RequestBody ClaimAresRequest request,
            Authentication auth) {
        Long userId = extractUserId(auth);
        return ResponseEntity.ok(ownerClaimService.lookupAres(request.getIco(), userId));
    }

    /**
     * Ověří identitu uživatele přes BankID a při shodě vytvoří členství OWNER.
     *
     * @param request požadavek obsahující IČO
     * @param auth    autentizační kontext přihlášeného uživatele
     * @return výsledek ověření BankID
     */
    @PostMapping("/bankid")
    public ResponseEntity<ClaimResultResponse> verifyBankId(
            @Valid @RequestBody ClaimBankIdRequest request,
            Authentication auth) {
        Long userId = extractUserId(auth);
        return ResponseEntity.ok(ownerClaimService.verifyBankId(request.getIco(), userId));
    }

    /**
     * Zahájí e-mailové ověření vlastnictví restaurace odesláním jednorázového kódu.
     *
     * @param request požadavek obsahující IČO
     * @param auth    autentizační kontext přihlášeného uživatele
     * @return výsledek zahájení e-mailového ověření
     */
    @PostMapping("/email/start")
    public ResponseEntity<ClaimResultResponse> startEmailClaim(
            @Valid @RequestBody ClaimEmailStartRequest request,
            Authentication auth) {
        Long userId = extractUserId(auth);
        return ResponseEntity.ok(ownerClaimService.startEmailClaim(request.getIco(), userId));
    }

    /**
     * Potvrdí e-mailové ověření vlastnictví restaurace pomocí jednorázového kódu.
     *
     * @param request požadavek obsahující IČO a ověřovací kód
     * @param auth    autentizační kontext přihlášeného uživatele
     * @return výsledek potvrzení ověření
     */
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
