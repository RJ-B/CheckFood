package com.example.CheckFood.domain.restaurant;

import java.util.List;

public interface RestaurantService {
    RestaurantDto createRestaurant(RestaurantDto dto);
    List<RestaurantDto> getAllRestaurants();
    RestaurantDto getRestaurantById(Long id);
    void deleteRestaurant(Long id);
}
