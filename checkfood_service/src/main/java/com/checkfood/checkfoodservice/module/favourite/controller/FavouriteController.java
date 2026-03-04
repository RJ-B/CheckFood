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

@RestController
@RequestMapping("/api/v1/users/me/favourites")
@RequiredArgsConstructor
public class FavouriteController {

    private final FavouriteService favouriteService;

    @GetMapping
    public ResponseEntity<List<RestaurantResponse>> getFavourites(
            @AuthenticationPrincipal UserDetails userDetails
    ) {
        return ResponseEntity.ok(favouriteService.getFavourites(userDetails.getUsername()));
    }

    @PutMapping("/{restaurantId}")
    public ResponseEntity<Void> addFavourite(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId
    ) {
        favouriteService.addFavourite(userDetails.getUsername(), restaurantId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{restaurantId}")
    public ResponseEntity<Void> removeFavourite(
            @AuthenticationPrincipal UserDetails userDetails,
            @PathVariable UUID restaurantId
    ) {
        favouriteService.removeFavourite(userDetails.getUsername(), restaurantId);
        return ResponseEntity.noContent().build();
    }
}
