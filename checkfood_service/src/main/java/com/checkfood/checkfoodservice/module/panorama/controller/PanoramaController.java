package com.checkfood.checkfoodservice.module.panorama.controller;

import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaPhotoResponse;
import com.checkfood.checkfoodservice.module.panorama.dto.PanoramaSessionResponse;
import com.checkfood.checkfoodservice.module.panorama.service.PanoramaService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

/**
 * REST kontroler pro správu panoramatických session restaurace přihlášeného majitele.
 * Umožňuje vytváření session, nahrávání fotografií, finalizaci a aktivaci panoramatu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/owner/restaurant/me/panorama")
@PreAuthorize("hasRole('OWNER')")
@RequiredArgsConstructor
public class PanoramaController {

    private final PanoramaService panoramaService;

    /**
     * Vytvoří novou panoramatickou session pro restauraci přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @return nově vytvořená panoramatická session
     */
    @PostMapping("/sessions")
    public ResponseEntity<PanoramaSessionResponse> createSession(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(panoramaService.createSession(userDetails.getUsername()));
    }

    /**
     * Nahraje jednu fotografii do panoramatické session.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param id          identifikátor session
     * @param angleIndex  index úhlu snímání (0–19)
     * @param actualAngle skutečný horizontální úhel fotoaparátu v době pořízení snímku
     * @param actualPitch skutečný vertikální úhel fotoaparátu (volitelný)
     * @param file        nahrávaný soubor fotografie
     * @return detail nahrané fotografie
     */
    @PostMapping(value = "/sessions/{id}/photos", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<PanoramaPhotoResponse> uploadPhoto(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id,
            @RequestParam("angleIndex") int angleIndex,
            @RequestParam("actualAngle") double actualAngle,
            @RequestParam(value = "actualPitch", required = false) Double actualPitch,
            @RequestParam("file") MultipartFile file) {
        return ResponseEntity.ok(panoramaService.uploadPhoto(
                userDetails.getUsername(), id, angleIndex, actualAngle, actualPitch, file));
    }

    /**
     * Finalizuje panoramatickou session a spustí asynchronní stitching fotografií.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param id          identifikátor session
     * @return aktualizovaná session ve stavu PROCESSING
     */
    @PostMapping("/sessions/{id}/finalize")
    public ResponseEntity<PanoramaSessionResponse> finalizeSession(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        return ResponseEntity.ok(panoramaService.finalizeSession(userDetails.getUsername(), id));
    }

    /**
     * Vrátí aktuální stav panoramatické session.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param id          identifikátor session
     * @return aktuální stav session
     */
    @GetMapping("/sessions/{id}")
    public ResponseEntity<PanoramaSessionResponse> getSessionStatus(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        return ResponseEntity.ok(panoramaService.getSessionStatus(userDetails.getUsername(), id));
    }

    /**
     * Vrátí seznam všech panoramatických session restaurace přihlášeného majitele.
     *
     * @param userDetails detail přihlášeného uživatele
     * @return seznam session seřazených od nejnovější
     */
    @GetMapping("/sessions")
    public ResponseEntity<List<PanoramaSessionResponse>> listSessions(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(panoramaService.listSessions(userDetails.getUsername()));
    }

    /**
     * Aktivuje dokončenou panoramatickou session jako aktuální panorama restaurace.
     *
     * @param userDetails detail přihlášeného uživatele
     * @param id          identifikátor session ve stavu COMPLETED
     * @return prázdná odpověď s HTTP 200
     */
    @PostMapping("/sessions/{id}/activate")
    public ResponseEntity<Void> setActivePanorama(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        panoramaService.setActivePanorama(userDetails.getUsername(), id);
        return ResponseEntity.ok().build();
    }
}
