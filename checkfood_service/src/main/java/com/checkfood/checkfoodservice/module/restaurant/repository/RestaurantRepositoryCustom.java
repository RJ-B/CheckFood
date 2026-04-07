package com.checkfood.checkfoodservice.module.restaurant.repository;

import com.checkfood.checkfoodservice.module.restaurant.entity.restaurant.Restaurant;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Vlastní fragment repozitáře pro dynamické nativní PostGIS dotazy s volitelnými filtry.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface RestaurantRepositoryCustom {

    /**
     * Vrátí stránkovaný seznam nejbližších restaurací s volitelnými filtry bez filtru oblíbených.
     *
     * @param lat         zeměpisná šířka uživatele
     * @param lng         zeměpisná délka uživatele
     * @param searchQuery fulltextový vyhledávací dotaz (může být null)
     * @param cuisineTypes seznam typů kuchyní pro filtrování (může být null)
     * @param minRating   minimální hodnocení (může být null)
     * @param openNow     filtr pouze otevřených restaurací (může být null)
     * @param pageable    parametry stránkování
     * @return stránka výsledků seřazená dle vzdálenosti
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

    /**
     * Vrátí stránkovaný seznam nejbližších restaurací s volitelnými filtry včetně filtru oblíbených.
     *
     * @param lat          zeměpisná šířka uživatele
     * @param lng          zeměpisná délka uživatele
     * @param searchQuery  fulltextový vyhledávací dotaz (může být null)
     * @param cuisineTypes seznam typů kuchyní pro filtrování (může být null)
     * @param minRating    minimální hodnocení (může být null)
     * @param openNow      filtr pouze otevřených restaurací (může být null)
     * @param favouriteIds sada UUID oblíbených restaurací pro filtrování (může být null)
     * @param pageable     parametry stránkování
     * @return stránka výsledků seřazená dle vzdálenosti
     */
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
