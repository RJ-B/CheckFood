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

@RestController
@RequestMapping("/api/v1/owner/restaurant/me/panorama")
@PreAuthorize("hasRole('OWNER')")
@RequiredArgsConstructor
public class PanoramaController {

    private final PanoramaService panoramaService;

    @PostMapping("/sessions")
    public ResponseEntity<PanoramaSessionResponse> createSession(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(panoramaService.createSession(userDetails.getUsername()));
    }

    @PostMapping(value = "/sessions/{id}/photos", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<PanoramaPhotoResponse> uploadPhoto(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id,
            @RequestParam("angleIndex") int angleIndex,
            @RequestParam("actualAngle") double actualAngle,
            @RequestParam("file") MultipartFile file) {
        return ResponseEntity.ok(panoramaService.uploadPhoto(
                userDetails.getUsername(), id, angleIndex, actualAngle, file));
    }

    @PostMapping("/sessions/{id}/finalize")
    public ResponseEntity<PanoramaSessionResponse> finalizeSession(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        return ResponseEntity.ok(panoramaService.finalizeSession(userDetails.getUsername(), id));
    }

    @GetMapping("/sessions/{id}")
    public ResponseEntity<PanoramaSessionResponse> getSessionStatus(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        return ResponseEntity.ok(panoramaService.getSessionStatus(userDetails.getUsername(), id));
    }

    @GetMapping("/sessions")
    public ResponseEntity<List<PanoramaSessionResponse>> listSessions(
            @AuthenticationPrincipal UserDetails userDetails) {
        return ResponseEntity.ok(panoramaService.listSessions(userDetails.getUsername()));
    }

    @PostMapping("/sessions/{id}/activate")
    public ResponseEntity<Void> setActivePanorama(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID id) {
        panoramaService.setActivePanorama(userDetails.getUsername(), id);
        return ResponseEntity.ok().build();
    }
}
