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
import java.util.Set;
import java.util.UUID;

/**
 * Implementace vlastního fragmentu repozitáře využívající EntityManager pro dynamické nativní SQL dotazy.
 * Spring Data JPA tuto implementaci detekuje automaticky díky suffixu "Impl".
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class RestaurantRepositoryCustomImpl implements RestaurantRepositoryCustom {

    @PersistenceContext
    private EntityManager entityManager;

    /**
     * {@inheritDoc}
     * Deleguje na přetíženou variantu s {@code favouriteIds = null}.
     */
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
        return findNearestWithFilters(lat, lng, searchQuery, cuisineTypes, minRating, openNow, null, pageable);
    }

    /**
     * {@inheritDoc}
     * Dynamicky sestavuje nativní SQL dotaz na základě předaných filtrů a spouští jej pomocí EntityManager.
     */
    @Override
    @SuppressWarnings("unchecked")
    public Page<Restaurant> findNearestWithFilters(
            double lat,
            double lng,
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow,
            Set<UUID> favouriteIds,
            Pageable pageable
    ) {
        StringBuilder sql = new StringBuilder();
        StringBuilder countSql = new StringBuilder();

        sql.append("SELECT * FROM restaurant r WHERE r.is_active = true");
        countSql.append("SELECT COUNT(*) FROM restaurant r WHERE r.is_active = true");

        String filters = buildFilterClauses(searchQuery, cuisineTypes, minRating, openNow, favouriteIds);
        sql.append(filters);
        countSql.append(filters);

        sql.append(" ORDER BY r.location <-> ST_SetSRID(ST_MakePoint(:lng, :lat), 4326)");
        sql.append(" LIMIT :limit OFFSET :offset");

        Query dataQuery = entityManager.createNativeQuery(sql.toString(), Restaurant.class);
        setParameters(dataQuery, lat, lng, searchQuery, cuisineTypes, minRating, openNow, favouriteIds);
        dataQuery.setParameter("limit", pageable.getPageSize());
        dataQuery.setParameter("offset", (int) pageable.getOffset());

        List<Restaurant> results = dataQuery.getResultList();

        Query countQuery = entityManager.createNativeQuery(countSql.toString());
        setParameters(countQuery, lat, lng, searchQuery, cuisineTypes, minRating, openNow, favouriteIds);
        long total = ((Number) countQuery.getSingleResult()).longValue();

        return new PageImpl<>(results, pageable, total);
    }

    /**
     * Sestaví dynamické klauzule WHERE na základě zadaných filtrů.
     *
     * @param searchQuery  fulltextový výraz (může být null)
     * @param cuisineTypes typy kuchyní (může být null nebo prázdný)
     * @param minRating    minimální hodnocení (může být null)
     * @param openNow      filtr pouze otevřených (může být null)
     * @param favouriteIds sada ID oblíbených (může být null nebo prázdná)
     * @return řetězec s SQL podmínkami začínající mezerou
     */
    private String buildFilterClauses(
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow,
            Set<UUID> favouriteIds
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

        if (favouriteIds != null && !favouriteIds.isEmpty()) {
            clauses.append(" AND r.id IN (:favouriteIds)");
        }

        return clauses.toString();
    }

    /**
     * Nastaví parametry dotazu na základě zadaných filtrů.
     * Parametry lat/lng jsou nastaveny v try-catch, protože count dotaz je nemá.
     *
     * @param query        dotaz, na který se nastavují parametry
     * @param lat          zeměpisná šířka
     * @param lng          zeměpisná délka
     * @param searchQuery  fulltextový výraz
     * @param cuisineTypes typy kuchyní
     * @param minRating    minimální hodnocení
     * @param openNow      filtr otevřených
     * @param favouriteIds sada oblíbených ID
     */
    private void setParameters(
            Query query,
            double lat,
            double lng,
            String searchQuery,
            List<String> cuisineTypes,
            Double minRating,
            Boolean openNow,
            Set<UUID> favouriteIds
    ) {
        try {
            query.setParameter("lat", lat);
            query.setParameter("lng", lng);
        } catch (IllegalArgumentException ignored) {
            // Count dotaz nepoužívá parametry lat/lng
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

        if (favouriteIds != null && !favouriteIds.isEmpty()) {
            query.setParameter("favouriteIds", favouriteIds);
        }
    }
}
