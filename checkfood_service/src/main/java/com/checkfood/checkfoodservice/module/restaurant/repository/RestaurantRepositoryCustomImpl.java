package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.time.DayOfWeek;
import java.time.LocalTime;
import java.util.List;

/**
 * Implementation of custom repository using EntityManager for dynamic native SQL.
 * Spring Data JPA auto-detects this via the "Impl" suffix convention.
 */
public class RestaurantRepositoryCustomImpl implements RestaurantRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @SuppressWarnings("unchecked")
    public Page<Restaurant> findNearestWithFilters(
            double lat,
            double lng,
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow,
            Pageable pageable
    ) {
        StringBuilder sql = new StringBuilder();
        StringBuilder countSql = new StringBuilder();

        // Base query
        sql.append("SELECT * FROM restaurant r WHERE r.is_active = true");
        countSql.append("SELECT COUNT(*) FROM restaurant r WHERE r.is_active = true");

        // Dynamic WHERE clauses
        String filters = buildFilterClauses(searchQuery, cuisineTypes, minRating, openNow);
        sql.append(filters);
        countSql.append(filters);

        // K-NN ordering
        sql.append(" ORDER BY r.location <-> ST_SetSRID(ST_MakePoint(:lng, :lat), 4326)");

        // Pagination
        sql.append(" LIMIT :limit OFFSET :offset");

        // Data query
        Query dataQuery = entityManager.createNativeQuery(sql.toString(), Restaurant.class);
        setParameters(dataQuery, lat, lng, searchQuery, cuisineTypes, minRating, openNow);
        dataQuery.setParameter("limit", pageable.getPageSize());
        dataQuery.setParameter("offset", (int) pageable.getOffset());

        List<Restaurant> results = dataQuery.getResultList();

        // Count query
        Query countQuery = entityManager.createNativeQuery(countSql.toString());
        setParameters(countQuery, lat, lng, searchQuery, cuisineTypes, minRating, openNow);
        long total = ((Number) countQuery.getSingleResult()).longValue();

        return new PageImpl<>(results, pageable, total);
    }

    private String buildFilterClauses(
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow
    ) {
        StringBuilder clauses = new StringBuilder();

        if (searchQuery != null && !searchQuery.isBlank()) {
            clauses.append(" AND LOWER(r.name) LIKE LOWER(:searchPattern)");
        }

        if (cuisineTypes != null && !cuisineTypes.isEmpty()) {
            clauses.append(" AND r.cuisine_type IN (:cuisineTypes)");
        }

        if (minRating != null) {
            clauses.append(" AND r.rating >= :minRating");
        }

        if (Boolean.TRUE.equals(openNow)) {
            clauses.append(" AND EXISTS (")
                    .append("SELECT 1 FROM restaurant_opening_hours oh")
                    .append(" WHERE oh.restaurant_id = r.id")
                    .append(" AND oh.day_of_week = :currentDay")
                    .append(" AND oh.is_closed = false")
                    .append(" AND :currentTime BETWEEN oh.open_at AND oh.close_at")
                    .append(")");
        }

        return clauses.toString();
    }

    private void setParameters(
            Query query,
            double lat,
            double lng,
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow
    ) {
        // Always set lat/lng — count query doesn't use them but won't fail with extra params
        try {
            query.setParameter("lat", lat);
            query.setParameter("lng", lng);
        } catch (IllegalArgumentException ignored) {
            // Count query doesn't have lat/lng params
        }

        if (searchQuery != null && !searchQuery.isBlank()) {
            query.setParameter("searchPattern", "%" + searchQuery + "%");
        }

        if (cuisineTypes != null && !cuisineTypes.isEmpty()) {
            query.setParameter("cuisineTypes", cuisineTypes);
        }

        if (minRating != null) {
            query.setParameter("minRating", minRating);
        }

        if (Boolean.TRUE.equals(openNow)) {
            query.setParameter("currentDay", DayOfWeek.from(java.time.LocalDate.now()).name());
            query.setParameter("currentTime", LocalTime.now());
        }
    }
}
