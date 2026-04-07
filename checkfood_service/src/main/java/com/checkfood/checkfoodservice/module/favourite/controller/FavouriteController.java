package com.checkfood.checkfoodservice.module.favourite.controller;

import com.checkfood.checkfoodservice.module.favourite.service.FavouriteService;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

/**
 * REST kontroler pro správu oblíbených restaurací přihlášeného uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@RestController
@RequestMapping("/api/v1/users/me/favourites")
@RequiredArgsConstructor
public class FavouriteController {

    private final FavouriteService favouriteService;

    /**
     * Vrátí seznam oblíbených restaurací přihlášeného uživatele.
     *
     * @param userDetails přihlášený uživatel
     * @return seznam oblíbených restaurací
     */
    @GetMapping
    public ResponseEntity<List<RestaurantResponse>> getFavourites(
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        return ResponseEntity.ok(favouriteService.getFavourites(userDetails.getUsername()));
    }

    /**
     * Přidá restauraci do oblíbených přihlášeného uživatele.
     *
     * @param userDetails  přihlášený uživatel
     * @param restaurantId UUID restaurace
     * @return HTTP 204 bez těla
     */
    @PutMapping("/{restaurantId}")
    public ResponseEntity<Void> addFavourite(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId
    ) {
        favouriteService.addFavourite(userDetails.getUsername(), restaurantId);
        return ResponseEntity.noContent().build();
    }

    /**
     * Odebere restauraci z oblíbených přihlášeného uživatele.
     *
     * @param userDetails  přihlášený uživatel
     * @param restaurantId UUID restaurace
     * @return HTTP 204 bez těla
     */
    @DeleteMapping("/{restaurantId}")
    public ResponseEntity<Void> removeFavourite(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId
    ) {
        favouriteService.removeFavourite(userDetails.getUsername(), restaurantId);
        return ResponseEntity.noContent().build();
    }
}
