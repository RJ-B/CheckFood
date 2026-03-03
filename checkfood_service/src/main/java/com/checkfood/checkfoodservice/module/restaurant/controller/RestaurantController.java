package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantMarkerResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;
import com.checkfood.checkfoodservice.module.restaurant.service.RestaurantService;
import com.checkfood.checkfoodservice.module.restaurant.service.TableManagementService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST Controller pro správu restaurací a jejich inventáře.
 */
@RestController
@RequestMapping("/api/v1/restaurants")
@RequiredArgsConstructor
public class RestaurantController {

    private final RestaurantService restaurantService;
    private final TableManagementService tableManagementService;

    // --- GEO / MAP ENDPOINTS (PUBLIC & OPTIMIZED FOR BIG DATA) ---

    /**
     * Inteligentní endpoint pro mapu (Smart Clustering).
     * <p>
     * Na základě velikosti výřezu (zoomu) vrací buď:
     * 1. Jednotlivé restaurace (pokud je uživatel blízko).
     * 2. Shluky (clustery) s počtem restaurací (pokud je uživatel daleko).
     * <p>
     * Příklad: /api/v1/restaurants/markers?minLat=49.7&maxLat=49.8&minLng=13.3&maxLng=13.4
     */
    @GetMapping("/markers")
    public ResponseEntity<List<RestaurantMarkerResponse>> getMarkers(
            @RequestParam double minLat,
            @RequestParam double maxLat,
            @RequestParam double minLng,
            @RequestParam double maxLng,
            @RequestParam int zoom
    ) {
        List<RestaurantMarkerResponse> markers = restaurantService.getMarkersInBounds(
                minLat, maxLat, minLng, maxLng, zoom
        );
        return ResponseEntity.ok(markers);
    }

    /**
     * Endpoint pro seznam: Vrací detailní data restaurací seřazená podle vzdálenosti.
     * Využívá PostGIS <-> operátor pro nejbližší sousedy (K-NN).
     * Příklad: /api/v1/restaurants/nearest?lat=49.74&lng=13.37&page=0&size=10
     */
    @GetMapping("/nearest")
    public ResponseEntity<List<RestaurantResponse>> getNearest(
            @RequestParam double lat,
            @RequestParam double lng,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String q,
            @RequestParam(required = false) List<String> cuisineTypes,
            @RequestParam(required = false) Double minRating,
            @RequestParam(required = false) Boolean openNow
    ) {
        return ResponseEntity.ok(
                restaurantService.getNearestRestaurants(lat, lng, page, size, q, cuisineTypes, minRating, openNow)
        );
    }

    // --- PUBLIC DETAIL ENDPOINT ---

    @GetMapping("/{id}")
    public ResponseEntity<RestaurantResponse> getRestaurant(@PathVariable UUID id) {
        return ResponseEntity.ok(restaurantService.getRestaurantById(id));
    }

    // --- MANAGEMENT ENDPOINTS (OWNER ONLY) ---

    @PostMapping
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<RestaurantResponse> createRestaurant(
            @Valid @RequestBody RestaurantRequest request,
            Authentication authentication) {

        UUID ownerId = extractUserId(authentication);
        RestaurantResponse response = restaurantService.createRestaurant(request, ownerId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/me")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<List<RestaurantResponse>> getMyRestaurants(Authentication authentication) {
        UUID ownerId = extractUserId(authentication);
        return ResponseEntity.ok(restaurantService.getMyRestaurants(ownerId));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<RestaurantResponse> updateRestaurant(
            @PathVariable UUID id,
            @Valid @RequestBody RestaurantRequest request,
            Authentication authentication) {

        UUID ownerId = extractUserId(authentication);
        return ResponseEntity.ok(restaurantService.updateRestaurant(id, request, ownerId));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteRestaurant(@PathVariable UUID id, Authentication authentication) {
        UUID ownerId = extractUserId(authentication);
        restaurantService.deleteRestaurant(id, ownerId);
    }

    // --- TABLE MANAGEMENT ENDPOINTS ---

    @PostMapping("/{id}/tables")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<RestaurantTableResponse> addTable(
            @PathVariable("id") UUID restaurantId,
            @Valid @RequestBody RestaurantTableRequest request,
            Authentication authentication) {

        UUID ownerId = extractUserId(authentication);
        return new ResponseEntity<>(
                tableManagementService.addTable(restaurantId, request, ownerId),
                HttpStatus.CREATED
        );
    }

    @GetMapping("/{id}/tables")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<List<RestaurantTableResponse>> getRestaurantTables(
            @PathVariable("id") UUID restaurantId) {

        return ResponseEntity.ok(tableManagementService.getTablesByRestaurant(restaurantId));
    }

    /**
     * Pomocná metoda pro získání UUID uživatele z Authentication kontextu.
     */
    private UUID extractUserId(Authentication authentication) {
        return UUID.fromString(authentication.getName());
    }
}