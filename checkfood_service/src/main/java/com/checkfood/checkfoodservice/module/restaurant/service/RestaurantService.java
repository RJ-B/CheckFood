package com.checkfood.checkfoodservice.module.restaurant.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.request.RestaurantRequest;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.AllMarkersResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantMarkerResponse;
import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;

import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;

import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Interface pro správu byznys logiky restaurací.
 *
 * <p>Vlastnictví restaurací je od Apr 2026 resolvováno výhradně přes tabulku
 * {@code restaurant_employee} (role = OWNER). Metody přijímají {@code userId}
 * typu {@link Long}, což je primární klíč {@link UserEntity}.</p>
 */
public interface RestaurantService {

    /**
     * Vytvoří novou restauraci a přiřadí danému uživateli roli OWNER v tabulce
     * restaurant_employee.
     *
     * @param request data nové restaurace
     * @param userId  ID přihlášeného uživatele (bude zapsán jako OWNER)
     */
    RestaurantResponse createRestaurant(RestaurantRequest request, Long userId);

    /**
     * Načte detail konkrétní restaurace.
     */
    RestaurantResponse getRestaurantById(UUID id);

    /**
     * Aktualizuje údaje existující restaurace.
     * Ověřuje, že uživatel má roli OWNER v této restauraci.
     *
     * @param id      UUID restaurace
     * @param request nová data
     * @param userId  ID přihlášeného uživatele
     */
    RestaurantResponse updateRestaurant(UUID id, RestaurantRequest request, Long userId);

    /**
     * Vrátí seznam všech restaurací, kde má daný uživatel roli OWNER.
     *
     * @param userId ID přihlášeného uživatele
     */
    List<RestaurantResponse> getMyRestaurants(Long userId);

    /**
     * Deaktivuje restauraci (soft-delete).
     * Vyžaduje roli OWNER v restaurant_employee.
     *
     * @param id     UUID restaurace
     * @param userId ID přihlášeného uživatele
     */
    void deleteRestaurant(UUID id, Long userId);

    // --- NOVÉ METODY PRO MAPU A SEZNAM (POSTGIS) ---

    /**
     * Získá lehké markery (ID + souřadnice) pro zobrazení na mapě v daném výřezu.
     * Slouží pro rychlé vykreslení bodů na mapě bez stahování detailů.
     *
     * @param minLat Spodní hranice zeměpisné šířky
     * @param maxLat Horní hranice zeměpisné šířky
     * @param minLng Levá hranice zeměpisné délky
     * @param maxLng Pravá hranice zeměpisné délky
     * @return Seznam markerů
     */
    List<RestaurantMarkerResponse> getMarkersInBounds(double minLat, double maxLat, double minLng, double maxLng, int zoom, Double clusterRadius);

    /**
     * Získá seznam restaurací seřazený podle vzdálenosti od uživatele.
     * Slouží pro "sjížděcí" seznam pod mapou.
     *
     * @param userLat Zeměpisná šířka uživatele
     * @param userLng Zeměpisná délka uživatele
     * @param page    Číslo stránky (0-indexed)
     * @param size    Počet položek na stránku
     * @return Seznam detailů restaurací
     */
    List<RestaurantResponse> getNearestRestaurants(double userLat, double userLng, int page, int size,
                                                     String searchQuery, List<String> cuisineTypes,
                                                     Double minRating, Boolean openNow);

    List<RestaurantResponse> getNearestRestaurants(double userLat, double userLng, int page, int size,
                                                     String searchQuery, List<String> cuisineTypes,
                                                     Double minRating, Boolean openNow,
                                                     Set<UUID> favouriteIds);

    UserEntity resolveUser(String email);

    // --- MARKER VERSIONING ---

    /**
     * Vrací všechny aktivní restaurace jako odlehčené markery s aktuální verzí.
     * Výsledek je cachován po dobu 5 minut.
     */
    AllMarkersResponse getAllActiveMarkers();

    /**
     * Vrací aktuální verzi sady markerů bez dat.
     * Klient ji porovná se svou lokální verzí pro detekci staleness.
     */
    long getMarkerVersion();

    /**
     * Inkrementuje verzi markerů a invaliduje cache.
     * Volá se po každé mutaci restaurace (create/update/delete).
     */
    void incrementMarkerVersion();
}
