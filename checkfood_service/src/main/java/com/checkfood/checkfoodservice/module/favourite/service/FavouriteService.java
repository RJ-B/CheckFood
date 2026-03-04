package com.checkfood.checkfoodservice.module.favourite.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;

import java.util.List;
import java.util.Set;
import java.util.UUID;

public interface FavouriteService {

    void addFavourite(String userEmail, UUID restaurantId);

    void removeFavourite(String userEmail, UUID restaurantId);

    List<RestaurantResponse> getFavourites(String userEmail);

    boolean isFavourite(String userEmail, UUID restaurantId);

    Set<UUID> getFavouriteIds(Long userId);
}
