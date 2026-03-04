package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Custom repository fragment for dynamic native PostGIS queries with optional filters.
 */
public interface RestaurantRepositoryCustom {

    Page<Restaurant> findNearestWithFilters(
            double lat,
            double lng,
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow,
            Pageable pageable
    );

    Page<Restaurant> findNearestWithFilters(
            double lat,
            double lng,
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow,
            Set<UUID> favouriteIds,
            Pageable pageable
    );
}
