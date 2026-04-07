package com.checkfood.checkfoodservice.module.favourite.service;

import com.checkfood.checkfoodservice.module.restaurant.dto.response.RestaurantResponse;

import java.util.List;
import java.util.Set;
import java.util.UUID;

/**
 * Service interface pro správu oblíbených restaurací uživatele.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public interface FavouriteService {

    /**
     * Přidá restauraci do oblíbených uživatele. Operace je idempotentní.
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace
     */
    void addFavourite(String userEmail, UUID restaurantId);

    /**
     * Odebere restauraci z oblíbených uživatele.
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace
     */
    void removeFavourite(String userEmail, UUID restaurantId);

    /**
     * Vrátí seznam oblíbených restaurací uživatele seřazený od nejnovějšího.
     *
     * @param userEmail e-mail přihlášeného uživatele
     * @return seznam response DTO oblíbených restaurací
     */
    List<RestaurantResponse> getFavourites(String userEmail);

    /**
     * Zjistí, zda je daná restaurace v oblíbených uživatele.
     *
     * @param userEmail    e-mail přihlášeného uživatele
     * @param restaurantId UUID restaurace
     * @return {@code true} pokud je restaurace v oblíbených, jinak {@code false}
     */
    boolean isFavourite(String userEmail, UUID restaurantId);

    /**
     * Vrátí množinu UUID oblíbených restaurací daného uživatele.
     *
     * @param userId ID uživatele
     * @return množina UUID oblíbených restaurací
     */
    Set<UUID> getFavouriteIds(Long userId);
}
