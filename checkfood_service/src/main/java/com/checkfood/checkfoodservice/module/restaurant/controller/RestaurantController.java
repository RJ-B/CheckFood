package com.checkfood.checkfoodservice.module.restaurant.controller;

import com.checkfood.checkfoodservice.module.restaurant.favourite.service.FavouriteService;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantTableRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.AllMarkersResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.MarkerVersionResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantMarkerResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantTableResponse;
import com.checkfood.checkfoodservice.module.restaurant.service.RestaurantService;
import com.checkfood.checkfoodservice.module.restaurant.service.TableManagementService;
import com.checkfood.checkfoodservice.security.module.user.service.UserService;
import com.checkfood.checkfoodservice.security.ratelimit.annotation.RateLimited;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.TimeUnit;

import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * REST controller pro veřejné i privátní operace nad restauracemi.
 * Zahrnuje geoprostorové endpointy pro mapu, detail restaurace a správu stolů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/restaurants")
@RequiredArgsConstructor
public class RestaurantController {

    private final RestaurantService restaurantService;
    private final TableManagementService tableManagementService;
    private final FavouriteService favouriteService;
    private final UserService userService;

    /**
     * Vrací všechny aktivní restaurace jako odlehčené markery spolu s verzí.
     * Klient si stáhne jednou, uloží do cache a porovnává s /markers-version.
     *
     * @return odpověď s verzí a seznamem markerů
     */
    @GetMapping("/all-markers")
    @RateLimited(key = "restaurant:all-markers", limit = 30, duration = 1, unit = TimeUnit.MINUTES, perIp = true)
    public ResponseEntity<AllMarkersResponse> getAllMarkers() {
        return ResponseEntity.ok(restaurantService.getAllActiveMarkers());
    }

    /**
     * Vrací pouze aktuální verzi sady markerů (číslo).
     * Slouží pro polling — pokud se verze liší od lokální cache, klient zavolá /all-markers.
     */
    @GetMapping("/markers-version")
    @RateLimited(key = "restaurant:markers-version", limit = 60, duration = 1, unit = TimeUnit.MINUTES, perIp = true)
    public ResponseEntity<MarkerVersionResponse> getMarkersVersion() {
        return ResponseEntity.ok(MarkerVersionResponse.builder()
                .version(restaurantService.getMarkerVersion())
                .build());
    }

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
    @RateLimited(key = "restaurant:markers", limit = 60, duration = 1, unit = TimeUnit.MINUTES, perIp = true)
    public ResponseEntity<List<RestaurantMarkerResponse>> getMarkers(
            @RequestParam double minLat,
            @RequestParam double maxLat,
            @RequestParam double minLng,
            @RequestParam double maxLng,
            @RequestParam int zoom,
            @RequestParam(required = false) Double clusterRadius
    ) {
        List<RestaurantMarkerResponse> markers = restaurantService.getMarkersInBounds(
                minLat, maxLat, minLng, maxLng, zoom, clusterRadius
        );
        return ResponseEntity.ok(markers);
    }

    /**
     * Endpoint pro seznam: Vrací detailní data restaurací seřazená podle vzdálenosti.
     * Využívá PostGIS <-> operátor pro nejbližší sousedy (K-NN).
     * Příklad: /api/v1/restaurants/nearest?lat=49.74&lng=13.37&page=0&size=10
     */
    @GetMapping("/nearest")
    @RateLimited(key = "restaurant:nearest", limit = 60, duration = 1, unit = TimeUnit.MINUTES, perIp = true)
    public ResponseEntity<List<RestaurantResponse>> getNearest(
            @RequestParam double lat,
            @RequestParam double lng,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String q,
            @RequestParam(required = false) List<String> cuisineTypes,
            @RequestParam(required = false) Double minRating,
            @RequestParam(required = false) Boolean openNow,
            @RequestParam(required = false) Boolean favouritesOnly,
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        Set<UUID> favouriteIds = null;
        if (Boolean.TRUE.equals(favouritesOnly) && userDetails != null) {
            var user = restaurantService.resolveUser(userDetails.getUsername());
            favouriteIds = favouriteService.getFavouriteIds(user.getId());
            if (favouriteIds.isEmpty()) {
                return ResponseEntity.ok(List.of());
            }
        }
        return ResponseEntity.ok(
                restaurantService.getNearestRestaurants(lat, lng, page, size, q, cuisineTypes, minRating, openNow, favouriteIds)
        );
    }

    @GetMapping("/{id}")
    @RateLimited(key = "restaurant:detail", limit = 120, duration = 1, unit = TimeUnit.MINUTES, perIp = true)
    public ResponseEntity<RestaurantResponse> getRestaurant(
            @PathVariable UUID id,
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        RestaurantResponse response = restaurantService.getRestaurantById(id);
        if (userDetails != null) {
            response.setIsFavourite(favouriteService.isFavourite(userDetails.getUsername(), id));
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<RestaurantResponse> createRestaurant(
            @Valid @RequestBody RestaurantRequest request,
            Authentication authentication) {

        Long userId = extractUserId(authentication);
        RestaurantResponse response = restaurantService.createRestaurant(request, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @GetMapping("/me")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<List<RestaurantResponse>> getMyRestaurants(Authentication authentication) {
        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(restaurantService.getMyRestaurants(userId));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<RestaurantResponse> updateRestaurant(
            @PathVariable UUID id,
            @Valid @RequestBody RestaurantRequest request,
            Authentication authentication) {

        Long userId = extractUserId(authentication);
        return ResponseEntity.ok(restaurantService.updateRestaurant(id, request, userId));
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteRestaurant(@PathVariable UUID id, Authentication authentication) {
        Long userId = extractUserId(authentication);
        restaurantService.deleteRestaurant(id, userId);
    }

    @PostMapping("/{id}/tables")
    @PreAuthorize("hasRole('RESTAURANT_OWNER')")
    public ResponseEntity<RestaurantTableResponse> addTable(
            @PathVariable("id") UUID restaurantId,
            @Valid @RequestBody RestaurantTableRequest request,
            Authentication authentication) {

        Long userId = extractUserId(authentication);
        return new ResponseEntity<>(
                tableManagementService.addTable(restaurantId, request, userId),
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
     * Extrahuje primární klíč přihlášeného uživatele z Authentication kontextu.
     * JWT subject obsahuje e-mail — entitu usera načteme přes {@link UserService}.
     *
     * @param authentication Spring Security authentication objekt
     * @return Long ID přihlášeného uživatele
     */
    private Long extractUserId(Authentication authentication) {
        return userService.findByEmail(authentication.getName()).getId();
    }
}