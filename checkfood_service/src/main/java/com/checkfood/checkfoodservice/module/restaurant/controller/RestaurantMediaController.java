package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantPhotoResponse;
import com.checkfood.checkfoodservice.module.restaurant.service.RestaurantMediaService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * REST controller pro správu mediálního obsahu restaurace — logo, cover obrázek a galerie fotek.
 * Vyžaduje roli OWNER nebo MANAGER s permission EDIT_RESTAURANT_INFO.
 *
 * <p>Public endpoint pro čtení galerie je dostupný také anonymně přes
 * {@code GET /api/v1/restaurants/{restaurantId}/gallery} (registrováno níže s vlastním PreAuthorize).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequiredArgsConstructor
public class RestaurantMediaController {

    private final RestaurantMediaService mediaService;

    // ---------- LOGO ----------

    @PostMapping(value = "/api/v1/owner/restaurants/{restaurantId}/logo",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
    public ResponseEntity<Map<String, String>> uploadLogo(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId,
            @RequestParam("file") MultipartFile file) {
        String url = mediaService.uploadLogo(userDetails.getUsername(), restaurantId, file);
        return ResponseEntity.ok(Map.of("url", url));
    }

    @DeleteMapping("/api/v1/owner/restaurants/{restaurantId}/logo")
    @PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
    public ResponseEntity<Void> deleteLogo(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId) {
        mediaService.deleteLogo(userDetails.getUsername(), restaurantId);
        return ResponseEntity.noContent().build();
    }

    // ---------- COVER ----------

    @PostMapping(value = "/api/v1/owner/restaurants/{restaurantId}/cover",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
    public ResponseEntity<Map<String, String>> uploadCover(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId,
            @RequestParam("file") MultipartFile file) {
        String url = mediaService.uploadCover(userDetails.getUsername(), restaurantId, file);
        return ResponseEntity.ok(Map.of("url", url));
    }

    @DeleteMapping("/api/v1/owner/restaurants/{restaurantId}/cover")
    @PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
    public ResponseEntity<Void> deleteCover(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId) {
        mediaService.deleteCover(userDetails.getUsername(), restaurantId);
        return ResponseEntity.noContent().build();
    }

    // ---------- GALLERY ----------

    @PostMapping(value = "/api/v1/owner/restaurants/{restaurantId}/gallery",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
    public ResponseEntity<RestaurantPhotoResponse> addGalleryPhoto(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId,
            @RequestParam("file") MultipartFile file) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(mediaService.addGalleryPhoto(userDetails.getUsername(), restaurantId, file));
    }

    @GetMapping("/api/v1/restaurants/{restaurantId}/gallery")
    public ResponseEntity<List<RestaurantPhotoResponse>> listGalleryPhotos(
            @PathVariable UUID restaurantId) {
        return ResponseEntity.ok(mediaService.listGalleryPhotos(restaurantId));
    }

    @DeleteMapping("/api/v1/owner/restaurants/{restaurantId}/gallery/{photoId}")
    @PreAuthorize("hasAnyRole('OWNER', 'MANAGER')")
    public ResponseEntity<Void> deleteGalleryPhoto(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId,
            @PathVariable UUID photoId) {
        mediaService.deleteGalleryPhoto(userDetails.getUsername(), restaurantId, photoId);
        return ResponseEntity.noContent().build();
    }
}
