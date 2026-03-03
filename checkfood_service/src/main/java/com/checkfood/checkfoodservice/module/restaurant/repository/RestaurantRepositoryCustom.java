package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * Custom repository fragment for dynamic native PostGIS queries with optional filters.
 */
public interface RestaurantRepositoryCustom {

    /**
     * Finds nearest restaurants with optional search and filter parameters.
     * Uses PostGIS K-NN operator for distance ordering.
     *
     * @param lat          User latitude
     * @param lng          User longitude
     * @param searchQuery  Optional case-insensitive name search (partial match)
     * @param cuisineTypes Optional list of cuisine type enum names to filter by
     * @param minRating    Optional minimum rating threshold
     * @param openNow      Optional flag to filter only currently open restaurants
     * @param pageable     Pagination info
     * @return Page of matching restaurants ordered by distance
     */
    Page<Restaurant> findNearestWithFilters(
            double lat,
            double lng,
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow,
            Pageable pageable
    );
}
